//
//  ContentView.swift
//  UITests
//
//  Created by amin nazemzadeh on 8/4/25.
//

import SwiftUI

struct ContentView: View {

    @State var sliderValue = 0.0
    @State var text: String = ""

//    init() {
//#if DEBUG
//if CommandLine.arguments.contains("enable-testing") {
////    configureAppForTesting()
//}
//#endif
//    }

    var body: some View {
        VStack {
            ProgressView(value: 1 - sliderValue)
                .accessibilityIdentifier("Inverse")
            Slider(value: $sliderValue)
                .accessibilityIdentifier("Completion")
            Text(text)
                .accessibilityIdentifier("TextCopy")
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
