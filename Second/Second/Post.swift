//
//  Post.swift
//  Second
//
//  Created by amin nazemzadeh on 7/31/25.
//

import Foundation

struct Post {
    let text: String
    let author: String
    let date: Date

    init(text: String, author: String, date: Date = .now) {
        self.text = text
        self.author = author
        self.date = date
    }
}
