//
//  SavedArticlesDAO.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 27.07.2024.
//

import Foundation
import SQLite

enum SavedArticlesDAO {

    enum Scheme {
        static let articles = Table("articles")
        static let id = Expression<UUID>("id")
        static let sourceName = Expression<String>("sourceName")
        static let author = Expression<String?>("author")
        static let title = Expression<String>("title")
        static let description = Expression<String?>("description")
        static let url = Expression<String>("url")
        static let urlToImage = Expression<String?>("urlToImage")
        static let publishedAt = Expression<String>("publishedAt")
    }

    static func create() -> String {
        Scheme.articles.create(ifNotExists: true) { t in
            t.column(Scheme.id, unique: true)
            t.column(Scheme.sourceName)
            t.column(Scheme.author)
            t.column(Scheme.title)
            t.column(Scheme.description)
            t.column(Scheme.url)
            t.column(Scheme.urlToImage)
            t.column(Scheme.publishedAt)
        }
    }
    
    static func allArticles() -> [Article] {
        do {
            return try DBManager.shared.connection
                .prepare(Scheme.articles)
                .map { row in
                    makeArticleFromRow(row: row)
                }
        }
        catch {
            assertionFailure("\(error)")
            return []
        }
    }

    static func saveOrUpdate(article: Article) {
        do {
            try DBManager.shared.connection.run(Scheme.articles.upsert(
                Scheme.id <- article.id,
                Scheme.sourceName <- article.source.name,
                Scheme.author <- article.author,
                Scheme.title <- article.title,
                Scheme.description <- article.description,
                Scheme.url <- article.url,
                Scheme.urlToImage <- article.urlToImage,
                Scheme.publishedAt <- article.publishedAt,
                onConflictOf: Scheme.id
            ))
        }
        catch {
            assertionFailure("\(error)")
        }
    }

    static func delete(article: Article) {
        do {
            try DBManager.shared.connection.run(
                Scheme.articles
                    .filter(Scheme.title == article.title)
                    .delete()
            )
        }
        catch {
            assertionFailure("\(error)")
        }
    }
}

// MARK: - Private

private extension SavedArticlesDAO {
    static func makeArticleFromRow(row: Row) -> Article {
        .init(
            id: row[Scheme.id],
            source: .init(name: row[Scheme.sourceName]),
            author: row[Scheme.author],
            title: row[Scheme.title],
            description: row[Scheme.description],
            url: row[Scheme.url],
            urlToImage: row[Scheme.urlToImage],
            publishedAt: row[Scheme.publishedAt]
        )
    }
}
