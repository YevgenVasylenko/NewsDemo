//
//  DBManager.swift
//  NewsDemo
//
//  Created by Yevgen Vasylenko on 27.07.2024.
//

import Foundation
import SQLite

final class DBManager {
    static let shared = DBManager()

    let connection: Connection

    private init() {
        connection = Self.makeConnection()
        createDBStructure()
    }
}

// MARK: - Private

private extension DBManager {
    static func makeConnection() -> Connection {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        do {
            return try Connection("\(path)/db.sqlite3")
        }
        catch {
            fatalError("\(error)")
        }
    }

    func createDBStructure() {
        do {
            try connection.run(SavedArticlesDAO.create())
        } catch {
            assertionFailure("\(error)")
        }
    }
}
