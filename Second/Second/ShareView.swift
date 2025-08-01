//
//  ShareView.swift
//  Second
//
//  Created by amin nazemzadeh on 7/31/25.
//

import SwiftUI

struct ShareView: View {
    @State private var text = ""
    var shareAction: (String) -> Void

    var body: some View {
        VStack {
            TextField("Enter some text", text: $text)
            Button("Share", action: shareTapped)
        }
    }

    func shareTapped() {
        shareAction(text)
    }
}
