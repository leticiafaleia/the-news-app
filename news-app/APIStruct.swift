//
//  APIStruct.swift
//  news-app
//
//  Created by Letícia Faleia on 15/05/25.
//

import Foundation

struct APIStruct: Codable {
    let articles: [Article]
}

struct Source: Codable {
    let name: String
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}
