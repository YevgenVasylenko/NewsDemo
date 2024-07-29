//
//  ArticlesManager.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 28.07.2024.
//

import Combine

final class SavedArticlesManager {
    static let shared = SavedArticlesManager()
    
    private let subject = CurrentValueSubject<[Article], Never>([])
    
    var articlesPublisher: some Publisher<[Article], Never> {
        subject
    }
    
    var articles: [Article] {
        subject.value
    }

    private init() {
        updateArticles()
    }
    
    func save(_ article: Article) {
        SavedArticlesDAO.saveOrUpdate(article: article)
        updateArticles()
    }
    
    func remove(_ article: Article) {
        SavedArticlesDAO.delete(article: article)
        updateArticles()
    }
}

// MARK: - Private

private extension SavedArticlesManager {
    func updateArticles() {
        subject.value = SavedArticlesDAO.allArticles()
    }
}
