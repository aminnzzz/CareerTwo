import UIKit

struct OrderedSet<Element: Hashable>: Equatable {
    public private(set) var array = [Element]()
    private var set = Set<Element>()

    var count: Int { array.count }
    var isEmpty: Bool { array.isEmpty }

    init() { }

    init(_ array: [Element]) {
        for element in array {
            append(element)
        }
    }

    @discardableResult
    mutating func append(_ newElement: Element) -> Bool {
        if set.insert(newElement).inserted {
            array.append(newElement)
            return true
        } else {
            return false
        }
    }

    func contains(_ member: Element) -> Bool {
        set.contains(member)
    }

    static func ==(lhs: OrderedSet, rhs: OrderedSet) -> Bool {
        return lhs.array == rhs.array
    }
}

extension OrderedSet: RandomAccessCollection {
    var startIndex: Int { array.startIndex }
    var endIndex: Int { array.endIndex }

    subscript(index: Int) -> Element {
        array[index]
    }
}
