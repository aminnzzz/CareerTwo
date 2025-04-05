import UIKit

enum GearError: Error {
    case tooHigh
    case tooLow
}

struct Car {
    var model: String
    private(set) var gear: Int = 1

//    mutating func changeGear(by: Int) throws(GearError)
    mutating func changeGear(by: Int) throws {
        let newGear = gear + by

        if newGear > 5 {
            throw GearError.tooHigh
        } else if newGear < 1 {
            throw GearError.tooLow
        }

        gear = newGear
    }
}
var car = Car(model: "Jaguar")

do {
    try car.changeGear(by: -1)
} catch GearError.tooHigh {
    print("You can't go that high")
} catch GearError.tooLow {
    print("You can't go that low")
} catch {
    print("Some unknown error occurred")
}

print("Car is now in gear \(car.gear).")

struct Car2 {
    var model: String
    private(set) var gear: Int = 1

    mutating func changeGear(by: Int) throws(GearError) {
        let newGear = gear + by

        if newGear > 5 {
            throw GearError.tooHigh
        } else if newGear < 1 {
            throw GearError.tooLow
        }

        gear = newGear
    }
}
var car2 = Car2(model: "Jaguar")

do {
    try car2.changeGear(by: -1)
} catch {
    switch error {
    case .tooHigh:
        print("You can't go that high")
    case .tooLow:
        print("You can't go that low")
    }
}

extension Sequence {
    @_alwaysEmitIntoClient
    public func count<E>(
        where predicate: (Element) throws(E) -> Bool
    ) throws(E) -> Int {
        var count = 0

        for e in self {
            count += try predicate(e) ? 1 : 0
        }

        return count
    }
}

let cars = [
    Car(model: "Jaguar", gear: 1),
    Car(model: "Mini", gear: 2),
    Car(model: "Ferrari", gear: 5)
]

let lowGearCars = cars.count { $0.gear <= 2 }
print(lowGearCars)
