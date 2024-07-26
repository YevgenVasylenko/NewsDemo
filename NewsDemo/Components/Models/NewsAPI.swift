//
//  NewsAPI.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import Foundation

struct NewsAPIResponse: Codable {
    let articles: [Article]
}

enum NewsAPI {
    
    enum Error: LocalizedError {
        case invalidParameters
        case invalidURL
        case underlying(Swift.Error)
    }
    
    static func articles() async -> Result<[Article], Error> {
        
        let response: Result<NewsAPIResponse, Error> = await response()
        
        switch response {
        case .failure(let error):
            return .failure(error)
            
        case .success(let response):
            return .success(response.articles)
        }
    }
}


private extension NewsAPI {
    
    static func response<Response: Codable>() async -> Result<Response, Error> {
        let apiKey = "c28b7b7681c4448990eba50ddc4b9ab5"
        let url = "https://newsapi.org/v2/top-headlines?country=ua&apiKey=\(apiKey)"
        guard let url = URL(string: url) else {
            assertionFailure("Invalid URL")
            return .failure(.invalidURL)
        }
        
        do {
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(Response.self, from: data)
            
            return .success(response)
        }
        catch {
            return .failure(.underlying(error))
        }
    }
}
