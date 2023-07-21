//
//  VMClass.swift
//  UserApp
//
//  Created by Mac on 19/07/23.
//

import Foundation
import CoreData
import UIKit

class VMClass {
    var context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    func saveFeed(data: NSDictionary){
        let article = Articles(context: context)
        article.title = data.value(forKey: "title") as? String ?? ""
        article.publishedAt = data.value(forKey: "publishedAt") as? String ?? ""
        article.articleDescription = data.value(forKey: "description") as? String ?? ""
        article.content = data.value(forKey: "content") as? String ?? ""
        article.url = data.value(forKey: "urlToImage") as? String ?? ""
        article.author = data.value(forKey: "author") as? String ?? ""
        print("done")
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "Not Found")
        do {
            try context.save()
        } catch {
            print(" error in saving")
        }
    }
}
