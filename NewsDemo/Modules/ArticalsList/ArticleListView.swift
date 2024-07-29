//
//  ArticleListView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

struct ArticleListView: View {
    
    @StateObject
    private var viewModel: ArticleListViewModel
    
    init(articleSource: ArticleSource) {
        _viewModel = .init(wrappedValue: .init(articleSource: articleSource))
    }
    
    var body: some View {
        if (viewModel.state.error == nil) {
            contentView()
        }
        else {
            ErrorMessageView(
                tryAgainAction: {
                    viewModel.fetchArticles()
                }
            )
        }
    }
}

// MARK: - Private

private extension ArticleListView {
    
    func contentView() -> some View {
        VStack(spacing: 0) {
            FilterFieldView(
                filterText: $viewModel.state.filterText,
                filterAction: {
                    viewModel.filter()
                }
            )
            newsListSearchResults()
        }
        .background(Color.backgroundTwo)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
    
    @ViewBuilder
    func newsListSearchResults() -> some View {
        if viewModel.state.filteredArticles.isEmpty  {
            if viewModel.state.filterText.isEmpty == false {
                emptyList(text: "Nothing was found ...")
            }
            else {
                emptyList(text: viewModel.articleSource.emptyListTitle)
            }
        }
        else {
            articleList()
        }
    }
    
    func emptyList(text: LocalizedStringKey) -> some View {
        VStack {
            Spacer()
            MessageText(text)
            Spacer()
        }
    }
    
    func articleList() -> some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(
                    viewModel.state.filteredArticles,
                    id: \.self,
                    content: articleView
                )
            }
        }
    }
    
    func articleView(_ article: Article) -> some View {
        let isSaved = viewModel.isSaved(article)
        
        return ArticleView(
            isArticleSaved: isSaved,
            article: article,
            needsConfirmForDelete: viewModel.articleSource == .saved,
            saveTap: {
                viewModel.actionForSaveButton(article: article)
            }
        )
        .padding(.horizontal, 15)
    }
}

private extension ArticleSource {
    var emptyListTitle: LocalizedStringKey {
        switch self {
        case .remote:
            "No news :-("
        case .saved:
            "You haven't saved the news yet ..."
        }
    }
}

#Preview {
    ArticleListView(articleSource: .saved)
}
