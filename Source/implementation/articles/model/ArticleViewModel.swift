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
    
    init(url: String, title: String, abstract: String, section: String, author: String, date: String, type: String) {
        self.url = url
        self.title = title
        self.abstract = abstract
        self.section = section
        self.author = author
        self.date = date
        self.type = type
    }
    
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
    
    init(entity: ArticleEntity) {
        self.url = entity.url
        self.title = entity.title
        self.abstract = entity.abstract
        self.section = entity.section
        self.author = entity.author
        self.date = entity.date
        self.type = entity.type
    }
}
