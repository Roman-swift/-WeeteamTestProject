//
//  ViewController.swift
//  Weeteam
//
//  Created by Admin on 5/28/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
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
    
    // MARK: - Helper

    func setupElements() {
        self.navigationItem.title = "Articles"
        
        self.mostEmailedView.layer.cornerRadius = 5
        self.mostEmailedButton.setTitle("Most Emailed", for: .normal)
        self.mostEmailedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.mostSharedView.layer.cornerRadius = 5
        self.mostSharedButton.setTitle("Most Shared", for: .normal)
        self.mostSharedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        self.mostViewedView.layer.cornerRadius = 5
        self.mostViewedButton.setTitle("Most Viewed", for: .normal)
        self.mostViewedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

    }
}

