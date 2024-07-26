//
//  Date+App.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 26.07.2024.
//

import Foundation

extension String {
    func articleDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "HH:mm"
        let formattedDate = dateFormatter.string(from: date ?? Date())
        return formattedDate.description
    }
}
