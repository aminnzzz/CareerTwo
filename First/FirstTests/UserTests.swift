//
//  UserTests.swift
//  FirstTests
//
//  Created by amin nazemzadeh on 7/18/25.
//

import Testing

extension Tag {
    @Tag static var user: Self
    @Tag static var dataHandling: Self
    @Tag static var measurement: Self
}

@Suite("User account tests", .timeLimit(.minutes(1)))
struct UserTests {
    @Test func newUserIsLoggedOut() {
        // test code here
    }

    @Test func authenticatedUserIsLoggedIn() {
        // test code here
    }
}
