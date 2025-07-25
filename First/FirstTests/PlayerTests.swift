//
//  PlayerTests.swift
//  FirstTests
//
//  Created by amin nazemzadeh on 7/23/25.
//

@testable import First
import Testing

struct DefaultPlayerTrait: TestTrait, TestScoping {
    func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: () async throws -> Void
    ) async throws {
        let player = Player(name: "Natsuki Subaru")

        try await Player.$current.withValue(player) {
            try await function()
        }
    }
}

extension Trait where Self == DefaultPlayerTrait {
    static var defaultPlayer: Self { Self() }
}

struct PlayerTests {

    @Test(.defaultPlayer) func welcomeScreenShowsName() {
        let result = Player.current.createWelcomeScreen()
        #expect(result.contains("Natsuki Subaru"))
    }

}
