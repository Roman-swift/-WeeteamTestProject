//
//  ArticleEntity + Extension.swift
//  Weeteam
//
//  Created by Admin on 5/29/20.
//  Copyright © 2020 Роман Родителев. All rights reserved.
//

import Foundation
import CoreData

extension ArticleEntity {
    
    /// create copy of Article in specified context
    @discardableResult
    private func makeCopy(in context: NSManagedObjectContext) -> ArticleEntity {
        let newArticle = ArticleEntity(context: context)
        newArticle.title = self.title
        newArticle.url = self.url
        newArticle.abstract = self.abstract
        newArticle.date = self.date
        newArticle.author = self.author
        newArticle.section = self.section
        
        return newArticle
    }
    
    func addToFavorite() {
        guard !isInFavorite() else { return }
        let mainContext = stack.mainContext
        self.makeCopy(in: mainContext)
        saveChanges()
    }
    
    func isInFavorite() -> Bool {
        let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
        
        do {
            let results = try stack.mainContext.fetch(request)
            return results.map{ $0.title }.contains(self.title)
        } catch {
            print("Couldn't perform fetch request")
        }
        return false
    }
    
    func delete() {
        stack.mainContext.delete(self)
        stack.saveContext()
    }
    
    func saveChanges() {
        stack.saveContext()
    }
}

