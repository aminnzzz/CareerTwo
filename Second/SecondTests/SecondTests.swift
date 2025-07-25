//
//  SecondTests.swift
//  SecondTests
//
//  Created by amin nazemzadeh on 7/25/25.
//

import Testing
@testable import Second

struct SecondTests {

    @Test func check4Bed2BathHouse_Fits3Bed2BathRequirements() {
        // given
        let house = House(bedrooms: 4, bathrooms: 2)
        let desiredBedrooms = 3
        let desiredBathrooms = 2

        // when
        let suitability = house.checkSuitability(desiredBedrooms: desiredBedrooms, desiredBathrooms: desiredBathrooms)

        // then
        #expect(suitability == true)
    }

    @Test func threeIngredientCakeCosts10() {
        // given
        let cake = Cake()
        let ingredients = ["chocolate", "cherries", "frosting"]

        // when
        let cost = cake.bake(ingredients: ingredients)

        // then
        #expect(cost == 10)
    }

}
