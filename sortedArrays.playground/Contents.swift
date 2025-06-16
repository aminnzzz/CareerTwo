import UIKit

struct SortedArray<Element>: RandomAccessCollection, CustomStringConvertible {
    private var items = [Element]()

    var count: Int { items.count }
    var description: String { items.description }
    var startIndex: Int { items.startIndex }
    var endIndex: Int { items.endIndex }
    var sortBefore: (Element, Element) -> Bool

    init(comparator: @escaping (Element, Element) -> Bool) {
        self.sortBefore = comparator
    }

    subscript(index: Int) -> Element {
        items[index]
    }

    mutating func insert(_ element: Element) {
        for (i, item) in items.enumerated() {
            if sortBefore(element, item) {
                items.insert(element, at: i)
                return
            }
        }

        items.append(element)
    }

    mutating func remove(at index: Int) {
        items.remove(at: index)
    }

    @warn_unqualified_access func min() -> Element? {
        items.first
    }

    @warn_unqualified_access func max() -> Element? {
        items.last
    }

    func minAndMax() -> (min: Element?, max: Element?) {
        (self.min(), self.max())
    }
}

extension SortedArray where Element: Comparable {
    init() {
        self.init(comparator: <)
    }
}
