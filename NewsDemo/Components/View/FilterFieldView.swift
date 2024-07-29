//
//  FilterFieldView.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 29.07.2024.
//

import SwiftUI

struct FilterFieldView: View {
    
    @FocusState
    private var isSearchInFocus: Bool
    
    @Binding
    var filterText: String
    
    let filterAction: () -> Void
    
    var body: some View {
        newsFilter()
    }
}

// MARK: - Private

extension FilterFieldView {
    
    func newsFilter() -> some View {
        HStack(spacing: 5) {
            searchIcon()
            searchField()
            cancelButton()
        }
        .padding(15)
        .background(RoundedRectangle(cornerRadius: 30)
            .fill(Color.backgroundOne)
        )
        .padding(15)
    }
    
    func searchIcon() -> some View {
        Image(systemName: "magnifyingglass")
            .foregroundStyle(Color.textLight)
    }
    
    func searchField() -> some View {
        TextField("Search", text: $filterText)
            .font(.system(size: 16, weight: .bold, design: .serif))
            .foregroundStyle(Color.textHeavy)
            .focused($isSearchInFocus)
            .onChange(of: filterText) {
                filterAction()
            }
    }
    
    @ViewBuilder
    func cancelButton() -> some View {
        if isSearchInFocus {
            Button(
                action: {
                    filterText = ""
                    isSearchInFocus = false
                },
                label: {
                    Image(systemName: "xmark.circle")
                }
            )
            .foregroundStyle(Color.textLight)
        }
    }
}

#Preview {
    @State
    var filterText = ""
    
    return FilterFieldView(filterText: $filterText, filterAction: {})
}
