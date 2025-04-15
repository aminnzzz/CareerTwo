//
//  ContentView.swift
//  LongPressButton
//
//  Created by amin nazemzadeh on 4/15/25.
//

import SwiftUI

struct LongPressButton: View {
    @GestureState private var pressed = false

    let image: Image
    var backgroundColor: Color = .clear
    var foregroundColor: Color = .primary
    var strokeColor: Color = .red
    var strokeWidth: CGFloat = 6
    var action: () -> Void

    var body: some View {
        image
            .font(.title)
            .foregroundColor(foregroundColor)
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)
            .padding()
            .background(
                Circle()
                    .fill(backgroundColor)
            )
            .overlay(
                Circle()
                    .rotation(.init(degrees: -90))
                    .trim(from: 0, to: pressed ? 1 : 0)
                    .stroke(strokeColor, style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round))
            )
            .gesture(
                LongPressGesture(minimumDuration: 0.5)
                    .updating($pressed) { new, existing, transaction in
                        existing = new
                    }
                    .onEnded { _ in
                        action()
                    }
            )
            .animation(.linear, value: pressed)
    }
}

struct ContentView: View {
    var body: some View {
        LongPressButton(image: Image(systemName: "bolt.fill")) {
            print("Activated!")
        }
    }
}

#Preview {
    ContentView()
}
