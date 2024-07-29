//
//  ErrorMessageView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 29.07.2024.
//

import SwiftUI

struct ErrorMessageView: View {
    
    let tryAgainAction: () -> Void
    
    var body: some View {
        errorMessage()
    }
}

// MARK: - Private

private extension ErrorMessageView {
    
    func errorMessage() -> some View {
        VStack {
            MessageText("Something went wrong")
            tryAgainButton()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundTwo)
    }
    
    func tryAgainButton() -> some View {
        Button(
            action: tryAgainAction,
            label: errorMessageLabel
        )
    }
    
    func errorMessageLabel() -> some View {
        Label("Try again", systemImage: "arrow.circlepath")
            .foregroundStyle(.backgroundOne)
            .font(.system(
                size: 16,
                weight: .semibold,
                design: .monospaced
            ))
            .padding(10)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.accentColor)
            )
    }
}

#Preview {
    ErrorMessageView(tryAgainAction: {})
}
