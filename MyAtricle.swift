//
//  MyAtricle.swift
//  UserApp
//
//  Created by Mac on 21/07/23.
//

import Foundation

class MyArticle: Codable {
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    var source: Source?
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
        case source = "source"
    }
}

class Source: Codable {
    var id: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}

class Arts: Codable {
    var articles: [MyArticle]
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }
}
