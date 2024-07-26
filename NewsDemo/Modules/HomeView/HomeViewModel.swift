//
//  HomeViewModel.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    
    struct State {
        var articles = [Article]()
    }
    
    @Published
    var state = State()
    
    func loadNews() {
        Task {
            let result = await NewsAPI.articles()

            switch result {
            case .success(let success):
                state.articles = success
            case .failure:
                state.articles = []
            }
        }
    }
}
