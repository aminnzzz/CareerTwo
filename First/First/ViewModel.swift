//
//  ViewModel.swift
//  First
//
//  Created by amin nazemzadeh on 7/23/25.
//

import Foundation

@Observable
class ViewModel {
    var names = [String]()

    func loadNames() async {
        // do some async work here
        names = ["Takemichi", "Draken"]
    }

    func loadReadings(completion: @Sendable @escaping ([Double]) -> Void) {
        let url = URL(string: "https://hws.dev/readings.json")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data {
                if let numbers = try? JSONDecoder().decode([Double].self, from: data) {
                    completion(numbers)
                    return
                }
            }

            completion([])
        }.resume()
    }
}
