//
//  ArticleView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

struct ArticleView: View {
    @State
    private var deleteAlertPresented = false

    private var isArticleSaved: Bool
    private let article: Article
    private let needsConfirmForDelete: Bool
    private let saveTap: () -> Void
    
    init(
         isArticleSaved: Bool,
         article: Article,
         needsConfirmForDelete: Bool,
         saveTap: @escaping () -> Void
    ) {
        self.isArticleSaved = isArticleSaved
        self.article = article
        self.needsConfirmForDelete = needsConfirmForDelete
        self.saveTap = saveTap
    }
    
    var body: some View {
        content()
            .deleteAlert(
                isPresented: $deleteAlertPresented,
                action: saveTap
            )
    }
}

// MARK: - Private

private extension ArticleView {
    
    func content() -> some View {
        VStack(spacing: 10) {
            articleImage()
            articleMain()
        }
        .padding(15)
        .background(Color.backgroundOne)
        .cornerRadius(30)
    }
    
    @ViewBuilder
    func articleImage() -> some View {
        if let urlToImage = article.urlToImage,
           let url = URL(string: urlToImage)
        {
            AsyncImage(url: url) { phase in
                phaseImage(phase: phase)
            }
            .frame(height: 100)
            .cornerRadius(30)
        }
    }
    
    @ViewBuilder
    func phaseImage(phase: AsyncImagePhase) -> some View {
        switch phase {
        case .success(let image):
            image
                .resizable()
                .scaledToFill()
        default:
            EmptyView()
        }
    }
    
    func articleMain() -> some View {
        VStack(spacing: 5) {
            sourceAndDate()
            articleBody()
        }
    }
    
    func sourceAndDate() -> some View {
        HStack {
            if let author = article.author {
                articleDetails(name: author)
                sourceSpacer()
            }
            articleDetails(name: article.source.name)
            Spacer()
            articleDetails(name: article.publishedAt.articleDate())
        }
    }
    
    func sourceSpacer() -> some View {
        Text(" • ")
    }
    
    func articleDetails(name: String) -> some View {
        Text(name)
            .foregroundStyle(Color.textLight)
            .lineLimit(1)
            .font(.system(
                size: 14,
                weight: .ultraLight,
                design: .monospaced
            ))
    }
    
    func articleBody() -> some View {
        HStack(spacing: 10) {
            saveButton()
            title()
            goToSourceButton()
        }
    }
    
    func saveButton() -> some View {
        Button(
            action: {
                if needsConfirmForDelete {
                    deleteAlertPresented = true
                }
                else {
                    saveTap()
                }
            },
            label: {
                Image(systemName: "arrow.down.doc.fill")
                    .font(.system(size: 25))
                    .foregroundColor(
                        isArticleSaved ? .accent : .notSelected
                    )
                    .frame(width: 44, height: 44)
            }
        )
    }
    
    func title() -> some View {
        Text(article.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(Color.textHeavy)
            .lineLimit(3)
            .font(.system(size: 16, weight: .bold, design: .serif))
    }
    
    @ViewBuilder
    func goToSourceButton() -> some View {
        if let url = URL(string: article.url) {
            Link(
                destination: url,
                label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 25))
                }
            )
            .frame(width: 44, height: 44)
        }
    }
}

private extension View {
    func deleteAlert(
        isPresented: Binding<Bool>,
        action: @escaping () -> Void
    ) -> some View {
        alert(
            "Are you sure you want delete from saved",
            isPresented: isPresented,
            actions: {
                Button(
                    "Remove",
                    role: .destructive,
                    action: action
                )
            }
        )
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
    
    return ArticleView(
        isArticleSaved: true,
        article: article,
        needsConfirmForDelete: true,
        saveTap: { }
    )
}
