//
//  Player.swift
//  First
//
//  Created by amin nazemzadeh on 7/23/25.
//

import Foundation

struct Player {
    var name: String
    var friends = [Player]()

    @TaskLocal static var current = Player(name: "Anonymous")

    func createWelcomeScreen() -> String {
        var message = "Welcome, \(Player.current.name)!\n"
        message += "Friends online: \(Player.current.friends.count)"
        return message
    }
}
