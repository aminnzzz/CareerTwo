//
//  DataHandling.swift
//  FirstTests
//
//  Created by amin nazemzadeh on 7/23/25.
//

@testable import First
import Testing

struct DataHandling {
    @Test("Loading view model names", .timeLimit(.minutes(1)))
    func loadNames() async {
        let viewModel = ViewModel()
        await viewModel.loadNames()
        #expect(viewModel.names.isEmpty == false, "Names should be full of values.")
    }

    @Test("Loading view model readings")
    func loadReadings() async {
        let viewModel = ViewModel()

        await withCheckedContinuation { continuation in
            viewModel.loadReadings { readings in
                #expect(readings.count >= 10, "At least 10 readings must be returned.")
                continuation.resume()
            }
        }
    }
}
