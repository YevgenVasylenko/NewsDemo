//
//  SavedArticleToggleStyle.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import SwiftUI

struct SaveToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(
            action: {
                configuration.isOn.toggle()
            },
            label: {
                body(configuration: configuration)
            }
        )
    }
    
    func body(configuration: Configuration) -> some View {
        Image(systemName: "arrow.down.doc.fill")
            .font(.system(size: 25))
            .foregroundColor(
                configuration.isOn ? .accent : .notSelected
            )
    }
}
