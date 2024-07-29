//
//  ArticleSource.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 28.07.2024.
//

import Combine

enum ArticleSource {
    case remote
    case saved
    
    func getArticles() async -> Result<[Article], Error> {
        switch self {
        case .remote:
            await NewsAPI.articles().mapError { $0 }
        case .saved:
            .success(SavedArticlesManager.shared.articles)
        }
    }
    
    var updated: any Publisher<[Article], Never> {
        switch self {
        case .remote:
            Empty()
        case .saved:
            SavedArticlesManager.shared.articlesPublisher
        }
    }
}
