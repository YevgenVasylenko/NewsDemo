//
//  MainView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

@MainActor
struct MainView: View {
        
    var body: some View {
        TabView {
            homeTab()
            savedTab()
        }
    }
}

// MARK: - Private

private extension MainView {
    func homeTab() -> some View {
        ArticleListView(articleSource: .remote)
            .tabItemView(label: "Home", iconName: "house.fill")
    }
    
    func savedTab() -> some View {
        ArticleListView(articleSource: .saved)
            .tabItemView(label: "Saved", iconName: "tray.and.arrow.down.fill")
    }
}

private extension View {
    
    func tabItemView(
        label: LocalizedStringKey,
        iconName: String
    ) -> some View {
        self
            .tabItem {
                Label(
                    label,
                    systemImage: iconName
                )
            }
            .background(Color.backgroundTwo)
            .padding(.bottom, 10)
    }
}

#Preview {
    MainView()
}
