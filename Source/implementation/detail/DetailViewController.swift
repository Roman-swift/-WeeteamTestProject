//
//  DetailViewController.swift
//  Weeteam
//
//  Created by Admin on 5/29/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet private weak var headingTitleLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var readmoreButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var abstractTextView: UITextView!
    
    var heading = "NY Times Article"
    var titleArtcile: String?
    var author: String?
    var articleUrl: String?
    var date: String?
    var abstract: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.headingTitleLabel.text = heading
        self.titleLabel.text = titleArtcile
        self.authorLabel.text = author
        self.dateLabel.text = date
        self.abstractTextView.text = abstract
        self.readmoreButton.addTarget(self, action: #selector(readmoreTapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc func readmoreTapped() {
        let urlPrivacyPolicy = URL(string:"\(articleUrl ?? "")")
        UIApplication.shared.open(urlPrivacyPolicy!, options: [:], completionHandler: nil)
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
}
