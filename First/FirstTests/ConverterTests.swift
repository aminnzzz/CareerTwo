//
//  ConverterTests.swift
//  FirstTests
//
//  Created by amin nazemzadeh on 7/10/25.
//

import Numerics
import Testing
@testable import First

struct ConverterTests {
    @Test(.tags(.measurement), arguments: [
        (32, 0),
        (212, 100),
        (-40, -40),
    ])
    func fahrenheitToCelsius(values: (input: Double, output: Double)) {
        // given
        let sut = Converter()

        // when
        let celsius = sut.convertToCelsius(fahrenheit: values.input)

        // then
        #expect(celsius == values.output)
    }

    @Test(
        .serialized,
        .bug("https://github.com/apple/swift-evolution/issues/2772", Comment(stringLiteral: "")),
        arguments: [0, 1, 2], ["red", "green", "blue"]
    )
    func combinatorics(first: Int, second: String) {
        print("\(first), \(second)")
    }
}
