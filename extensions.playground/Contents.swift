import Foundation

protocol Compressible { }
protocol Printable { }

struct Image { }

extension Image: Compressible { }
extension Image: Printable { }

struct Image {
    init(from url: URL) {

    }
}

extension Image {
    private init(data: Data) {

    }
}

// DataController.swift
class DataController {

}

// DataController-StoreKit.swift
extension DataController {
    // In-app purchase code here
}

// DataController-Notifications.swift
extension DataController {
    // Code for handling user notifications here
}

struct Rectangle {
    var width: Double
    var height: Double
}

extension Rectangle {
    init(squareOf side: Double) {
        width = side
        height = side
    }
}

extension String {
    func trimmingCharacters(in set: CharacterSet) -> String {
        print("I don't think so!")
        return self
    }
}

extension Array {
    var total: Element {
        reduce(0, +)
    }
}

extension Array where Element: Numeric {
    var total: Element {
        reduce(0, +)
    }
}

extension Collection where Element: Hashable {
    var isUnique: Bool {
        self.count == Set(self).count
    }
}

extension String {
    var isUnique: Bool {
        let words = self.split(separator: /[. ,!?]/)
        return words.count == Set(words).count
    }
}

extension Optional: Equatable where Wrapped: Equatable {
    @inlinable
    public static func ==(lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        switch (lhs, rhs) {
        case let (l?, r?):
            return l == r
        case (nil, nil):
            return true
        default:
            return false
        }
    }
}

struct Stack<Element> {
    private var array = [Element]()
    var count: Int { array.count }
    var isEmpty: Bool { array.isEmpty }

    init() { }

    init(_ items: [Element]) {
        self.array = items
    }

    mutating func push(_ element: Element) {
        array.append(element)
    }

    mutating func pop() -> Element? {
        array.popLast()
    }

    func peek() -> Element? {
        array.last
    }
}

extension Stack: Equatable where Element: Equatable { }

extension Stack: Hashable where Element: Hashable { }


extension Stack: Encodable where Element: Encodable { }
extension Stack: Decodable where Element: Decodable { }
