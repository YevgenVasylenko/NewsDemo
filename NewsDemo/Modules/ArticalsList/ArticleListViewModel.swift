//
//  ArticleListViewModel.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class ArticleListViewModel: ObservableObject {
    
    struct State {
        var filteredArticles = [Article]()
        var filterText = ""
        var error: Error?
        fileprivate var savedArticleTitles = Set<String>()
    }
    
    @Published
    var state = State()
    
    let articleSource: ArticleSource
    private var allArticles = [Article]()
    private var cancellables = [AnyCancellable]()
    
    init(articleSource: ArticleSource) {
        self.articleSource = articleSource
        subscribeArticleUpdates()
    }
    
    func fetchArticles() {
        Task {
            let articles = await articleSource.getArticles()
            update(with: articles)
        }
    }
    
    func subscribeArticleUpdates() {
        articleSource.updated
            .sink { [weak self] articles in
                self?.update(with: .success(articles))
            }
            .store(in: &cancellables)
        
        SavedArticlesManager.shared.articlesPublisher
            .sink { [weak self] savedArticles in
                self?.state.savedArticleTitles = Set(savedArticles.map { $0.title })
            }
            .store(in: &cancellables)
    }
    
    func filter() {
        if state.filterText.isEmpty {
            state.filteredArticles = allArticles
        }
        else {
            state.filteredArticles = allArticles.filter { article in
                article.contains(text: state.filterText)
            }
        }
    }
    
    func isSaved(_ article: Article) -> Bool {
        state.savedArticleTitles.contains(article.title)
    }
    
    func actionForSaveButton(article: Article) {
        isSaved(article)
        ? remove(article)
        : save(article)
    }
}

// MARK: - Private

private extension ArticleListViewModel {

    func update(with articles: Result<[Article], Error>) {
        switch articles {
        case .success(let articles):
            allArticles = articles
            state.error = nil
        case .failure(let failure):
            allArticles = []
            state.error = failure
        }
        filter()
    }

    func save(_ article: Article) {
        SavedArticlesManager.shared.save(article)
    }
    
    func remove(_ article: Article) {
        SavedArticlesManager.shared.remove(article)
    }
}

private extension Article {
    func contains(text: String) -> Bool {
        title.localizedCaseInsensitiveContains(text)
        || source.name.localizedCaseInsensitiveContains(text)
    }
}
