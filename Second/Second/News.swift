//
//  News.swift
//  Second
//
//  Created by amin nazemzadeh on 8/1/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

struct News {
    var url: URL
    var stories = ""

    mutating func fetch(using session: any URLSessionProtocol = URLSession.shared) async throws {
        let (data, _) = try await session.data(from: url)
        stories = String(decoding: data, as: UTF8.self)
    }
}
