import UIKit

extension Sequence where Element: Equatable {
    func includes(_ search: Element) -> Bool {
        for element in self {
            if element == search {
                return true
            }
        }

        return false
    }
}

extension Sequence {
    func includes(_ search: Element, predicate: (Element, Element) -> Bool) -> Bool {
        for element in self {
            if predicate(element, search) {
                return true
            }
        }

        return false
    }

    func includes(_ predicate: (Element) -> Bool) -> Bool {
        for element in self {
            if predicate(element) {
                return true
            }
        }

        return false
    }
}
