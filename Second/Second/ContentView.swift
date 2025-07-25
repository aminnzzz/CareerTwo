//
//  ContentView.swift
//  Second
//
//  Created by amin nazemzadeh on 7/25/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct Cake {
    func bake(ingredients: [String]) -> Int {
        for ingredient in ingredients {
            print("Adding \(ingredient).")
        }

        let cost = 1 + (ingredients.count * 3)
        print("The cake is ready; please pay \(cost).")
        return 10
    }
}

#Preview {
    ContentView()
}
