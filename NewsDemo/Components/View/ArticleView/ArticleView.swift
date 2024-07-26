//
//  ArticleView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        content()
    }
}

// MARK: - Private

private extension ArticleView {
    
    func content() -> some View {
        VStack(spacing: 0) {
            if article.urlToImage != nil {
                articleImage()
            }
            articleMain()
        }
        .background(Color.backgoundOne)
        .cornerRadius(30)
        .padding(5)
    }
    
    func articleImage() -> some View {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                phaseImage(phase: phase)
            }
            .frame(height: 100)
            .cornerRadius(30)
            .padding(10)
    }
    
    @ViewBuilder
    func phaseImage(phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            EmptyView()
        case .success(let image):
            image
                .resizable()
                .scaledToFill()
        case .failure:
            EmptyView()
        @unknown default:
            EmptyView()
        }
    }
    
    func articleMain() -> some View {
        VStack(spacing: 10) {
            sourceAndDate()
            articleBody()
        }
        .padding(20)
        .cornerRadius(30)
    }
    
    func sourceAndDate() -> some View {
        HStack {
            articleDetails(name: article.source.name)
            Spacer()
            articleDetails(name: article.publishedAt.articleDate())
        }
    }
    
    func articleDetails(name: String) -> some View {
        Text(name)
            .foregroundStyle(Color.textLight)
            .font(.system(
                size: 14,
                weight: .ultraLight,
                design: .monospaced)
            )
    }
    
    func articleBody() -> some View {
        HStack(spacing: 10) {
            saveButton()
            title()
            goToSourceButton()
        }
    }
    
    func saveButton() -> some View {
        Toggle("", isOn: .constant(false))
            .toggleStyle(SaveToggleStyle())
    }
    
    func title() -> some View {
        Text(article.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.textHeavy)
            .lineLimit(3)
            .font(.system(size: 16, weight: .bold, design: .serif))
    }
    
    func goToSourceButton() -> some View {
        Link(
            destination: URL(string: article.url)!,
            label: {
            Image(systemName: "arrowshape.right.fill")
                    .font(.system(size: 25))
        })
    }
}

#Preview {
    let article = Article(
        source: .init(name: "Radiosvoboda.org"),
        author: "Радіо Свобода",
        title: "Винищувачі США і Канади перехопили російські й китайські військові літаки поблизу Аляски – NORAD - Радіо Свобода",
        description: "«NORAD залишається готовим застосувати низку варіантів відповіді для захисту Північної Америки»",
        url: "https://www.radiosvoboda.org/a/news-litaky-rf-kytau-perekhoplennia/33050335.html",
        urlToImage: "https://gdb.rferl.org/E404C1E7-52B5-4C60-9D03-A1AE121B9239_w1200_r1.jpg",
        publishedAt: "2024-07-25T08:58:23Z"
    )
    
    return ArticleView(article: article)
}
