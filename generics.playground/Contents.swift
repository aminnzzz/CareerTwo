import UIKit

func count<Number: Numeric>(numbers: [Number]) {
    let total = numbers.reduce(0, +)
    print("Total is \(total)")
}


protocol Prioritized {
    var priority: Int { get }
    func alertIfImportant()
}
struct Work: Prioritized {
    let priority: Int

    func alertIfImportant() {
        if priority > 3 {
            print("I'm important work!")
        }
    }
}

struct Document: Prioritized {
    let priority: Int

    func alertIfImportant() {
        if priority > 5 {
            print("I'm an important document!")
        }
    }
}
func checkPriority(of item: Prioritized) {
    print("Checking priority…")
    item.alertIfImportant()
}
func checkPriority<P: Prioritized>(of item: P) {
    print("Checking priority…")
    item.alertIfImportant()
}


struct Pair<T> {
    var first: T
    var second: T
}

struct ParticleState<T> {
    var start: T
    var end: T

    init(_ start: T, _ end: T) {
        self.start = start
        self.end = end
    }
}

struct Point<T: Numeric> {
    var x: T
    var y: T
}

struct Scoreboard<T: Numeric> {
    var highScore: T
    var allScores: [T]
}

struct CountedSet<Element: Hashable>: Equatable, Hashable {
    private var elements = [Element: Int]()
    var count: Int { elements.count }
    var isEmpty: Bool { elements.isEmpty }

    mutating func insert(_ element: Element) {
        elements[element, default: 0] += 1
    }

    mutating func remove(_ element: Element) {
        elements[element, default: 0] -= 1
    }

    func count(for element: Element) -> Int {
        elements[element, default: 0]
    }
}

extension Array where Element: Equatable {
    mutating func removing(_ obj: Element) -> [Element] {
        filter { $0 != obj }
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen = Set<Element>()

        return filter {
            seen.insert($0).inserted
        }
    }
}

extension Sequence {
    func uniqueElements<T: Hashable>(byProperty propertyAccessor: (Element) -> T) -> [Element] {
        var seen = Set<T>()
        var result = [Element]()

        for element in self {
            let property = propertyAccessor(element)
            if seen.contains(property) == false {
                result.append(element)
                seen.insert(property)
            }
        }

        return result
    }
}

struct User {
    var name: String
}

let user1 = User(name: "User1")
let user2 = User(name: "User2")
let user3 = User(name: "User3")
let users = [user1, user2, user1, user3, user2, user1, user2]

let uniqueUsers = users.uniqueElements { $0.name }


let uniqueUsers2 = users.uniqueElements(byProperty: \.name)


extension Sequence {
    func uniqueElements2<T: Hashable>(byProperty propertyAccessor: (Element) -> T) -> [Element] {
        var seen = Set<T>()
        return filter {
            return seen.insert(propertyAccessor($0)).inserted
        }
    }
}

@propertyWrapper struct NonNegative<Value: SignedNumeric & Comparable> {
    var value: Value

    init(wrappedValue: Value) {
        self.value = max(0, wrappedValue)
    }

    var wrappedValue: Value {
        get { value }
        set { value = max(0, newValue) }
    }
}

struct SpeedTracker {
    @NonNegative var current = 0.0
    @NonNegative var highest = 0.0
}
