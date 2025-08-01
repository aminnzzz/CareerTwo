//
//  Home.swift
//  Second
//
//  Created by amin nazemzadeh on 8/1/25.
//

import Foundation

protocol HouseProtocol {
    var numberOfViewings: Int { get set }
    func conductViewing()
}

class Home: HouseProtocol {
    var numberOfViewings = 0

    func conductViewing() {
        numberOfViewings += 1
    }
}
