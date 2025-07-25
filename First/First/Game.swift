//
//  Game.swift
//  First
//
//  Created by amin nazemzadeh on 7/16/25.
//

import Foundation

enum GameError: Error {
    case notPurchased
    case notInstalled
    case parentalControlsDisallowed
}

struct Game {
    let name: String

    func play() throws {
        if name == "BioBlitz" {
            throw GameError.notPurchased
        } else if name == "Blastazap" {
            throw GameError.notInstalled
        } else if name == "Patch Match" {
            throw GameError.parentalControlsDisallowed
        } else {
            print("\(name) is okay to play!")
        }
    }
}
