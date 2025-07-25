//
//  FirstTests.swift
//  FirstTests
//
//  Created by amin nazemzadeh on 7/10/25.
//

import Foundation
import Testing
@testable import First

extension Array where Element: Equatable {
    func fuzzyMatches(other: Array) -> Bool {
        guard self.count == other.count else {
            return false
        }

        var selfCopy = self

        for item in other {
            if let index =
                selfCopy.firstIndex(of: item) {
                selfCopy.remove(at: index)
            } else {
                return false
            }
        }

        return true
    }
}

struct FirstTests {

    func randomAge() -> Int {
        Int.random(in: 0...120)
    }

    @Test func studentStartsAtHome() async throws {
        let student = Student()
        #expect(student.isAtSchool == false, "New students should not be at school.")
    }

    @Test func studentGoesToSchool() async throws {
        // Given
        var student = Student()

        // When
        student.goToSchool()

        // Then
        #expect(student.isAtSchool == true)
    }

    @Test func studentLeavesSchool() async throws {
        var student = Student()
        student.goToSchool()
        student.leaveSchool()
        #expect(student.isAtSchool == false)
    }

    func createTestUser(projects: Int, itemsPerProject: Int) throws -> User {
        var user = User(name: UUID().uuidString)
        try #require(user.projects.isEmpty)

        for album in 1...projects {
            var project = Project(name: "Album #\(album)")
            try #require(project.items.isEmpty)

            for song in 1...itemsPerProject {
                let item = ToDoItem(name: "Write song #\(song)")
                project.addToDoItem(item)
            }

            user.addProject(project)
        }

        return user
    }

    @Test func outstandingTasksStringIsPlural() throws {
        // given
        let sut = try createTestUser(projects: 3, itemsPerProject: 10)

        // when
        let rowTitle = sut.outstandingTasksString

        // then
        #expect(rowTitle == "30 items")
    }

    func divisionRemainder(of number: Int, dividedBy: Int) -> (quotient: Int, remainder: Int) {
        let quotient = number / dividedBy
        let remainder = number % dividedBy
        return (quotient, remainder)
    }

    func verifyDivision(
        _ result: (quotient: Int, remainder: Int),
        expectedQuotient: Int,
        expectedRemainder: Int,
        sourceLocation: SourceLocation = #_sourceLocation
    ) {
        #expect(result.quotient == expectedQuotient, sourceLocation: sourceLocation)
        #expect(result.remainder == expectedRemainder, sourceLocation: sourceLocation)
    }

    @Test func divisors() {
        // given
        let dividend = 12
        let divisor = 4

        // when
        let result = divisionRemainder(of: dividend, dividedBy: divisor)

        // then
        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 2)
    }

    @Test func divisionRemainder() {
        // given
        let dividend = 10
        let divisor = 3

        // when
        let result = divisionRemainder(of: dividend, dividedBy: divisor)

        // then
        verifyDivision(result, expectedQuotient: 3, expectedRemainder: 1)
    }

    @Test("DoubleGenerator should create 63 doubles")
    func doubling() async {
        let generator = DoubleGenerator()

        await confirmation(expectedCount: 63) { confirm in
            for await _ in generator {
                confirm()
            }
        }
    }

    @Test func fiveToTenFeedsAreLoaded() async throws {
        let loader = NewsLoader()

        await confirmation(expectedCount: 5...10) { confirm in
            for await _ in loader {
                confirm()
            }
       }
    }

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
}
