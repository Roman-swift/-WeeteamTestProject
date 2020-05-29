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
import CoreData

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
    var articlesDB = [ArticleEntity]()
    var selectedTap: Int!
    var favorites: Bool = false
    
    private var sortedArticlesDB = [ArticleEntity]()
    private var selectedIndexPath: IndexPath? = nil
    private var refreshControl = UIRefreshControl()
    private var typeOfArticle: ArticlePaths.Request?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(refresh), for:.valueChanged)
        self.articlesTableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !favorites {
            activityIndicator.startAnimating()
            self.loadDataFromApi()
        } else {
            self.downloadFavourite()
        }
    }
    
    func loadDataFromApi() {
        
        switch selectedTap {
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
    
    // MARK: - Helper
    
    private func showErrorAlert(){
        self.activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "No internet connection", message: "Please, check your connection to Internet.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            alert.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    @objc func refresh(_ sender: Any) {
        if Connectivity.isConnectedToInternet() {
            activityIndicator.startAnimating()
            self.loadDataFromApi()
            self.refreshControl.endRefreshing()
        } else {
            self.showErrorAlert()
        }
    }
    
    private func downloadFavourite() {
        self.fetchArtcileFromCoreDataWithPredicate()
        self.activityIndicator.stopAnimating()
    }
    
    private func fetchArtcileFromCoreDataWithPredicate(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedObject = appDelegate.persistentContainer.viewContext
        let articleFetchRequest = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        
        do {
            let articles = try managedObject.fetch(articleFetchRequest)
            for article in articles{
                articlesDB.append(article)
                self.sortedArticlesDB = Array(Set(self.articlesDB))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func setupDataBaseDetail(_ model: ArticleEntity) -> UIViewController{
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let articleVC =  storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        articleVC.titleArtcile = model.title
        articleVC.author = model.author
        articleVC.articleUrl = model.url
        articleVC.date = model.date
        articleVC.abstract = model.abstract
        return articleVC
    }
    
    func setupNetworkDetail(_ model: ArticleViewModel) -> UIViewController{
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        let articleVC =  storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        articleVC.titleArtcile = model.title
        articleVC.author = model.author
        articleVC.articleUrl = model.url
        articleVC.date = model.date
        articleVC.abstract = model.abstract
        return articleVC
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ArticlesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites {
            return articlesDB.count
        } else {
            return articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesListViewController", for: indexPath) as! ArticleTableViewCell
        
        if favorites {
            cell.configureFromDb(sortedArticlesDB[indexPath.row])
        } else {
            cell.configure(self.articles[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexPath != indexPath && !favorites{
            let vc = self.setupNetworkDetail(articles[indexPath.row])
            vc.modalPresentationStyle = .fullScreen
            selectedIndexPath = nil
            tableView.deselectRow(at: indexPath, animated: false)
            self.present(vc, animated: true, completion: nil)
        } else {
            selectedIndexPath = indexPath
            tableView.deselectRow(at: indexPath, animated: false)
            let vc = self.setupDataBaseDetail(sortedArticlesDB[indexPath.row])
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
