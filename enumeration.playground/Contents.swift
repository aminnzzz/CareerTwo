import UIKit

class LinkedList<T> {
    var start: LinkedListNode<T>?
}

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?

    init(value: T) {
        self.value = value
    }
}

class LinkedListIterator<T>: IteratorProtocol {
    // holds the item we're currently reading
    private var current: LinkedListNode<T>?

    // an initializer giving us the start of the list
    init(start: LinkedListNode<T>?) {
        current = start
    }

    // move one place along and return that node
    func next() -> LinkedListNode<T>? {
        defer { current = current?.next }
        return current
    }
}

extension LinkedList: Sequence {
    func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(start: start)
    }
}

struct FibonacciGenerator {
    var previous = 0
    var current = 1
}

extension FibonacciGenerator: Sequence, IteratorProtocol {
    mutating func next() -> Int? {
        defer {
            let next = previous + current
            previous = current
            current = next
        }

        return current
    }
}

struct DoubleGenerator: AsyncSequence {
    struct AsyncIterator: AsyncIteratorProtocol {
        var current = 1

        mutating func next() async -> Int? {
            // before you write in to report a typo, &*= is correct in the code below!
            defer { current &*= 2 }

            if current < 0 {
                return nil
            } else {
                return current
            }
        }
    }

    func makeAsyncIterator() -> AsyncIterator {
        AsyncIterator()
    }

    func printAllDoubles() async {
        for await number in DoubleGenerator() {
            print(number)
        }
    }

    func containsExactNumber() async {
        let doubles = DoubleGenerator()
        let match = await doubles.contains(16_777_216)
        print(match)
    }
}
