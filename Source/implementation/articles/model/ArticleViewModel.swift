//
//  ArticleViewModel.swift
//  Weeteam
//
//  Created by Admin on 5/28/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import UIKit
import ObjectMapper

class ArticleViewModel: NSObject, Mappable {
    
    var url: String?
    var title: String?
    var abstract: String?
    var section: String?
    var author: String?
    var date: String?
    var type: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        url <- map["url"]
        title <- map["title"]
        abstract <- map["abstract"]
        section <- map["section"]
        author <- map["byline"]
        date <- map["published_date"]
        type <- map["type"]
    }
    
    
}
