//
//  User.swift
//  Second
//
//  Created by amin nazemzadeh on 7/30/25.
//

import Foundation

protocol UserProtocol {
    var funds: Decimal { get set }
    var age: Int { get set }
    var games: [GameProtocol] { get set }

    mutating func buy(_ game: GameProtocol) -> Bool
}

struct User: UserProtocol {
    var funds: Decimal
    var age: Int
    var games: [GameProtocol]

    mutating func buy(_ game: GameProtocol) -> Bool {
        let possible = game.canBePurchased(by: self)

        if possible {
            games.append(game)
            funds -= game.price
            return true
        } else {
            return false
        }
    }
}
