import UIKit

final class LinkedListNode<Element> {
    var value: Element
    var next: LinkedListNode?

    init(value: Element, next: LinkedListNode? = nil) {
        self.value = value
        self.next = next
    }
}

final class LinkedList<Element> {
    var start: LinkedListNode<Element>?
}

let third = LinkedListNode(value: 5)
let second = LinkedListNode(value: 3, next: third)
let first = LinkedListNode(value: 1, next: second)

let list = LinkedList<Int>()
list.start = first

var currentNode = list.start

while let node = currentNode {
    print(node.value, terminator: " ")
    currentNode = node.next
}


final class LinkedListV2<Element>: ExpressibleByArrayLiteral, Sequence {
    var start: LinkedListNode<Element>?

    public init(arrayLiteral elements: Element...) {
        for element in elements.reversed() {
            start = LinkedListNode(value: element, next: start)
        }
    }

    init(array: Array<Element>) {
        for element in array.reversed() {
            start = LinkedListNode(value: element, next: start)
        }
    }

    func makeIterator() -> LinkedListIterator<Element> {
        LinkedListIterator(current: start)
    }
}

struct LinkedListIterator<Element>: IteratorProtocol {
    var current: LinkedListNode<Element>?

    mutating func next() -> LinkedListNode<Element>? {
        defer { current = current?.next }
        return current
    }
}


struct LinkedListEnum<Element> {
    var start: LinkedListNode<Element>
}

indirect enum LinkedListNodeEnum<Element> {
    case node(value: Element, next: LinkedListNodeEnum<Element>?)
}
