//
//  Article.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import Foundation

struct Article: Codable, Hashable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}

extension Article {
    struct Source: Codable, Hashable {
        let name: String
    }
}
