//
//  SecondTests.swift
//  SecondTests
//
//  Created by amin nazemzadeh on 7/25/25.
//

import Foundation
import Testing
@testable import Second
import UIKit

class URLSessionMock: URLSessionProtocol {
    var lastURL: URL?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        lastURL = url
        return (Data(), URLResponse())
    }
}

class URLSessionMock2: URLSessionProtocol {
    var testData: Data?
    var testError: (any Error)?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let testError {
            throw testError
        } else {
            (testData ?? Data(), URLResponse())
        }
    }
}

struct DeviceMock: DeviceProtocol {
    var testBatteryState: UIDevice.BatteryState

    var batteryState: UIDevice.BatteryState {
        testBatteryState
    }
}

class HouseMock: HouseProtocol {
    var numberOfViewings = 0

    func conductViewing() {
        numberOfViewings += 1
    }
}

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

    @Test func userCantBuyUnreleasedGame() {
        struct UnreleasedGameStub: GameProtocol {
            var price: Decimal = 0
            var minimumAge = 0
            var isReleased = false

            func canBePurchased(by user: UserProtocol) -> Bool {
                false
            }
        }
        
        // given
        var sut = User(funds: 100, age: 21, games: [])
        let game = UnreleasedGameStub()

        type(of: game).printTerms()

        // when
        let wasBought = sut.buy(game)

        // then
        #expect(wasBought == false)
    }

    @Test func viewingHouseAddsOneToViewings() {
        // given
        let house = Home()
        let startViewings = house.numberOfViewings

        // when
        house.conductViewing()

        // then
        #expect(house.numberOfViewings == startViewings + 1)
    }

    @Test func buyerViewingHouseAddsOneToViewings() {
        // given
        let buyer = Buyer()
        let house = HouseMock()

        // when
        buyer.view(house)

        // then
        #expect(house.numberOfViewings == 1)
    }

    @MainActor @Test(arguments: [
        (UIDevice.BatteryState.unplugged, "Power is down"),
        (UIDevice.BatteryState.unknown, "Error"),
        (UIDevice.BatteryState.charging, "Power is up")
    ]) func powerStatusMatcheString(values: (state: UIDevice.BatteryState, message: String)) {
        // given
        let sut = PowerMonitor(device: DeviceMock(testBatteryState: values.state))

        // when
        let status = sut.getStatus()

        // then
        #expect(status == values.message)
    }

    @Test func newsFetchLoadsCorrectURL() async throws {
        // given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        var news = News(url: url)
        let session = URLSessionMock()

        // when
        try await news.fetch(using: session)

        // then
        #expect(session.lastURL == url)
    }

    @Test func newsStoriesAreFetched() async throws {
        // given
        let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
        var news = News(url: url)
        let session = URLSessionMock2()
        session.testData = Data("Hello, world!".utf8)

        // when
        try await news.fetch(using: session)

        // then
        #expect(news.stories == "Hello, world!")
    }
}
