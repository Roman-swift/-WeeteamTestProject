//
//  PostTableViewCell.swift
//  Networking
//
//  Created by Viacheslav Bilyi on 7/25/19.
//  Copyright © 2019 Viacheslav Bilyi. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
	@IBOutlet weak var articleBodyLable: UILabel!

    private var article: ArticleViewModel?

	func configure(_ article: ArticleViewModel) {
        DispatchQueue.main.async {
            self.myView.layer.cornerRadius = 15
            self.myView.layer.masksToBounds = false
            self.myView.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.myView.layer.shadowColor = UIColor.black.cgColor
            self.myView.layer.shadowOpacity = 0.23
            self.myView.layer.shadowRadius = 5
            
            self.article = article
            
            self.articleTitleLabel.text = article.title
            self.articleTitleLabel.textColor = .white
            
            self.articleAuthorLabel.text =
            article.author
            self.articleAuthorLabel.textColor = .white

            self.articleBodyLable.text = article.abstract
            self.articleBodyLable.textColor = .white

        }
	}
}
