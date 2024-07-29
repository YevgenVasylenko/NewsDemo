//
//  MessageText.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 28.07.2024.
//

import SwiftUI

struct MessageText: View {
    
    private let text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .foregroundStyle(.textLight)
            .font(.system(
                size: 16,
                weight: .ultraLight,
                design: .monospaced)
            )
    }
}
