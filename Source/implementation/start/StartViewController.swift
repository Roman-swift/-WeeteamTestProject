//
//  ViewController.swift
//  Weeteam
//
//  Created by Admin on 5/28/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet private weak var mostEmailedView: UIView!
    @IBOutlet private weak var mostEmailedButton: UIButton!
    @IBOutlet private weak var mostSharedView: UIView!
    @IBOutlet private weak var mostSharedButton: UIButton!
    @IBOutlet private weak var mostViewedView: UIView!
    @IBOutlet private weak var mostViewedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupElements()
    }
    
    // MARK: - Actions
    @IBAction func didTapFvouritesButton(_ sender: Any) {
        let vc = UIStoryboard(name: "ArticlesList", bundle: nil).instantiateViewController(withIdentifier: "ArticlesListViewController") as! ArticlesListViewController
        vc.favorites = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapMostEmailedButton(_ sender: Any) {
        let vc = UIStoryboard(name: "ArticlesList", bundle: nil).instantiateViewController(withIdentifier: "ArticlesListViewController") as! ArticlesListViewController
        vc.selectedTap = 0

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapMostSharedButton(_ sender: Any) {
        let vc = UIStoryboard(name: "ArticlesList", bundle: nil).instantiateViewController(withIdentifier: "ArticlesListViewController") as! ArticlesListViewController
        vc.selectedTap = 1

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapMostViewedButton(_ sender: Any) {
        let vc = UIStoryboard(name: "ArticlesList", bundle: nil).instantiateViewController(withIdentifier: "ArticlesListViewController") as! ArticlesListViewController
        vc.selectedTap = 2

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Helper

    func setupElements() {
        self.navigationItem.title = "NY Times Article"
        
        self.mostEmailedView.layer.cornerRadius = 15
        self.mostEmailedButton.setTitle("Most Emailed", for: .normal)
        self.mostEmailedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.mostSharedView.layer.cornerRadius = 15
        self.mostSharedButton.setTitle("Most Shared", for: .normal)
        self.mostSharedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        self.mostViewedView.layer.cornerRadius = 15
        self.mostViewedButton.setTitle("Most Viewed", for: .normal)
        self.mostViewedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

    }
}

