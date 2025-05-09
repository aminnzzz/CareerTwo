import UIKit

func meanAverage(of numbers: [Double]) -> Double {
    guard numbers.isEmpty == false else { return 0 }

    var total = 0.0

    for number in numbers {
        total += number
    }

    return total / Double(numbers.count)
}

let numbers: [Double] = [1, 2, 3, 4, 5]
let mean1 = meanAverage(of: numbers)
print(mean1)

let copiedFunction: ([Double]) -> Double = meanAverage
let mean2 = copiedFunction(numbers)
print(mean2)

struct Classroom {
    let teacher: String
    let averageCalculator: ([Double]) -> Double
}

let archer = Classroom(teacher: "Mr Archer", averageCalculator: meanAverage)

let figgis = Classroom(teacher: "Mr Figgis") { numbers in
    guard numbers.count > 0 else { return 0 }

    var total = 0.0

    for number in numbers {
        total += number
    }

    return total / Double(numbers.count)
}

struct User {
    let name = "Taylor Swift"

    func printGreeting() {
        print("Hi, I'm \(name)!")
    }
}

struct Employee {
    let greetTeam: () -> Void
}

let taylor = User()

let cheryl = Employee(greetTeam: taylor.printGreeting)
cheryl.greetTeam()

let not = (!)

if not(true) {
    print("You are anonymous")
}

// let add = (+) // won't work, two ints, strings, what???
let add: (Int, Int) -> Int = (+)
print(add(1, 5))

let names = ["Bobby", "Jonathan", "Antoni", "Karamo", "Tan"]
let sortedNames = names.sorted()
let sortedNames2 = names.sorted().reversed()
let sortedNames3 = names.sorted { $0 > $1 }
let sortedNames4 = names.sorted(by: >)

let albums = ["Folklore", "Lover", "1989"]
let result1 = albums.allSatisfy { $0.count >= 4 }
let result2 = albums.allSatisfy { $0.contains("o") }

let message = "Taylor Swift's most popular albums include Folklore, Lover, and 1989."
let result3 = message.contains("Lover")
let result4 = albums.allSatisfy(message.contains)
var result5 = true

for album in albums {
    if message.contains(album) == false {
        result5 = false
        break
    }
}

var counter = 0

let increment = {
    counter += 1
    print("Call count: \(counter)")
}

increment()
increment()
increment()

let copy = increment

copy()
increment()
copy()
increment()
