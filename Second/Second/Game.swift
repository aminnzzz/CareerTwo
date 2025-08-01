//
//  Game.swift
//  Second
//
//  Created by amin nazemzadeh on 7/28/25.
//

import Foundation

protocol GameProtocol {
    var price: Decimal { get set }
    var minimumAge: Int { get set }
    var isReleased: Bool { get set }

    func canBePurchased(by user: UserProtocol) -> Bool
}

extension GameProtocol {
    static func printTerms() {
        print("Here are 50 pages of terms and conditions for you to read on a tiny phone screen.")
    }
}

struct Game: GameProtocol {
    var price: Decimal
    var minimumAge: Int
    var isReleased: Bool

    func canBePurchased(by user: UserProtocol) -> Bool {
        guard isReleased else {
            return false
        }

        guard user.funds >= price else {
            return false
        }

        if user.age >= minimumAge {
            return true
        } else {
            return false
        }
    }
}
