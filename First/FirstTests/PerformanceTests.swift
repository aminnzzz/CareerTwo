//
//  PerformanceTests.swift
//  FirstTests
//
//  Created by amin nazemzadeh on 7/24/25.
//

import XCTest

@testable import First
import XCTest

class PerformanceTest: XCTestCase {
    func testPrimePerformance() {
        measure {
            _ = PrimeCalculator.calculate(upTo: 1_000_000)
        }
    }
}
