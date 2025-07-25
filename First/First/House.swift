//
//  House.swift
//  First
//
//  Created by amin nazemzadeh on 7/24/25.
//

import Foundation

struct House {
    var bedrooms: Int
    var bathrooms: Int
    var cost: Int

    init(bedrooms: Int, bathrooms: Int) {
        self.bedrooms = bedrooms
        self.bathrooms = bathrooms
        self.cost = bedrooms * bathrooms * 50_000
    }

    func checkSuitability(desiredBedrooms: Int, desiredBathrooms: Int) -> Bool {
        if bedrooms >= desiredBedrooms && bathrooms >= desiredBathrooms {
            true
        } else {
            false
        }
    }
}
