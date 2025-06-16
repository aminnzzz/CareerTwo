import UIKit

struct NodeIterator<Value>: IteratorProtocol {
    var items: [Node<Value>]
    var position = 0

    mutating func next() -> Node<Value>? {
        if position < items.count {
            defer { position += 1 }
            return items[position]
        } else {
            return nil
        }
    }
}

class Node<Value>: Sequence {
    var value: Value
    private(set) var left: Node?
    private(set) var right: Node?
    var count = 1

    init(_ value: Value) {
        self.value = value
    }

    func makeIterator() -> NodeIterator<Value> {
        return NodeIterator(items: Array(self), position: 0)
    }
}

extension Array {
    init<T>(_ node: Node<T>) where Element == Node<T> {
        self = [Node<T>]()

        if let left = node.left {
            self += Array(left)
        }

        self += [node]

        if let right = node.right {
            self += Array(right)
        }
    }
}

extension Node where Value: Equatable {
    func find(_ search: Value) -> Node? {
        for node in self {
            if node.value == search {
                return node
            }
        }

        return nil
    }
}

extension Node where Value: Comparable {
    func insert(_ newValue: Value) {
        if newValue < value {
            if left == nil {
                left = Node(newValue)
            } else {
                left?.insert(newValue)
            }
        } else if newValue > value {
            if right == nil {
                right = Node(newValue)
            } else {
                right?.insert(newValue)
            }
        } else {
            count += 1
        }
    }

    func fastFind(_ search: Value) -> Node? {
        if value == search {
            return self
        }

        if search < value {
            return left?.fastFind(search)
        } else {
            return right?.fastFind(search)
        }
    }
}
