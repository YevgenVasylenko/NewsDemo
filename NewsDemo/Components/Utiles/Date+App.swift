//
//  Date+App.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import Foundation

extension String {
    func articleDate() -> String {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: self)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        return timeFormatter.string(from: date ?? Date())
    }
}
