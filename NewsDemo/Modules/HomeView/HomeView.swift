//
//  HomeView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject
    var viewModel = HomeViewModel()
    
    var body: some View {
        content()
            .onAppear {
                viewModel.loadNews()
            }
    }
}

// MARK: - Private

private extension HomeView {
    func content() -> some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(viewModel.state.articles, id: \.self) { article in
                    ArticleView(article: article)
                        .padding(.horizontal, 10)
                }
            }
        }
        .background(Color.backgroundTwo)
    }
}

#Preview {
    HomeView()
}
