//
//  RequestPaths.swift
//  Weeteam
//
//  Created by Admin on 5/28/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import Foundation

// MARK: - Base URL

public enum BaseURL {
    static let baseURL =  "https://api.nytimes.com/svc/mostpopular/v2"
}

// MARK: - ArticlesPaths

public enum ArticlePaths {
    static let endpoint = "api-key=KeQMmp5nGfF8XPoUh2Sp4TxKXYViYBeN"
    
    enum Request: String {
        case mostEmailed = "/emailed/30.json?"
        case mostShared = "/shared/30/facebook.json?"
        case mostViewes = "/viewed/30.json?"

        func url() -> String {
            return BaseURL.baseURL + rawValue + ArticlePaths.endpoint
        }
    }
}


