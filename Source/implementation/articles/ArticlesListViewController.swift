//
//  ArticlesListViewController.swift
//  Weeteam
//
//  Created by Admin on 5/28/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ArticlesListViewController: UIViewController {
    
    @IBOutlet private weak var articlesTableView: UITableView! {
        didSet {
            articlesTableView.delegate = self
            articlesTableView.dataSource = self
            let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
            articlesTableView.register(nib, forCellReuseIdentifier: "ArticlesListViewController")
        }
    }
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var articles = [ArticleViewModel]()
    var tap: Int!
    private var articleService = ArticleListService()
    private var refreshControl = UIRefreshControl()
    private var typeOfArticle: ArticlePaths.Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for:.valueChanged)
        self.articlesTableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if Connectivity.isConnectedToInternet() {
            activityIndicator.startAnimating()
            self.loadDataFromApi()
        } else {
            self.showErrorAlert()
        }
    }
    
    
    func loadDataFromApi() {
        
        switch tap {
        case 0:
            typeOfArticle = .mostEmailed
        case 1:
            typeOfArticle = .mostShared
        case 2:
            typeOfArticle = .mostViewes
        default:
            break
        }
        
        let url = ArticlePaths.Request.url(typeOfArticle ?? ArticlePaths.Request.mostEmailed)
        
        AF.request(url(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print(response)
            switch response.result {
            case .success:
                if let responseJson = response.value as? NSDictionary {
                    if let articleDetailJson = responseJson["results"] as? [[String: Any]] {
                        for i in 0..<articleDetailJson.count {
                            print(articleDetailJson[i])
                            
                            let articleMdl = Mapper<ArticleViewModel>().map(JSONObject: articleDetailJson[i])
                            self.articles.append(articleMdl!)
                        }
                        
                        DispatchQueue.main.async {
                            self.articlesTableView.reloadData()
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func showErrorAlert(){
        self.activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "No internet connection", message: "Please, check your connection to Internet.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    //    func saveNewPost (_ article: ArticleViewModel) {
    //        self.articles.append(article)
    //        DispatchQueue.main.async {
    //            self.articlesTableView.reloadData()
    //        }
    //    }
    //
    //    func removePost (_ indexPath: IndexPath) {
    //        DispatchQueue.main.async {
    //            self.articles.remove(at: indexPath.row)
    //            self.articlesTableView.deleteRows(at: [indexPath], with: .fade)
    //        }
    //    }
    
    @objc func refresh(_ sender: Any) {
        if Connectivity.isConnectedToInternet() {
            activityIndicator.startAnimating()
            self.loadDataFromApi()
            self.refreshControl.endRefreshing()
        } else {
            self.showErrorAlert()
        }
    }
}

extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesListViewController", for: indexPath) as! ArticleTableViewCell
        cell.configure(articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleModel = articles[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let articleVC =  storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        articleVC.titleArtcile = articleModel.title
        articleVC.author = articleModel.author
        articleVC.articleUrl = articleModel.url
        articleVC.date = articleModel.date
        articleVC.abstract = articleModel.abstract
        articleVC.modalPresentationStyle = .fullScreen
        self.present(articleVC, animated: true, completion: nil)
    }
}
