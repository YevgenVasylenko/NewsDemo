//
//  MainView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

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
        HomeView()
            .tabItem {
                Label(
                    "Home",
                    systemImage: "house.fill"
                )
            }
//            .toolbarBackground(.red, for: .tabBar)
    }
    
    func savedTab() -> some View {
        SavedView()
            .tabItem {
                Label(
                    "Saved",
                    systemImage: "tray.and.arrow.down.fill"
                )
            }
            
    }
}

#Preview {
    MainView()
}
