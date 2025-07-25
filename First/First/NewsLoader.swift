//
//  NewsLoader.swift
//  First
//
//  Created by amin nazemzadeh on 7/23/25.
//

import Foundation

struct NewsLoader: AsyncSequence, AsyncIteratorProtocol {
    var current = 1

    mutating func next() async -> Data? {
        defer { current += 1 }

        do {
            let url = URL(string: "https://hws.dev/news-\(current).json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return data.isEmpty ? nil : data
        } catch {
            return nil
        }
    }

    func makeAsyncIterator() -> NewsLoader {
        self
    }
}
