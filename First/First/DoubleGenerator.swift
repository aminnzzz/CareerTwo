//
//  DoubleGenerator.swift
//  First
//
//  Created by amin nazemzadeh on 7/23/25.
//

import Foundation

struct DoubleGenerator: AsyncSequence, AsyncIteratorProtocol {
    var current = 1

    mutating func next() async -> Int? {
        defer { current &*= 2 }

        if current < 0 {
            return nil
        } else {
            return current
        }
    }

    func makeAsyncIterator() -> DoubleGenerator {
        self
    }
}
