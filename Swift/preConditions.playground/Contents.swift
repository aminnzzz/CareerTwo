import UIKit

let names1 = ["Gary", "Jack", "Quinn"]
print(names1[0])
print(names1[3])

let roles = ["Captain": "Mal", "Engineer": "Kaylee"]
print(roles["Pilot"]!)

let names2 = ["Gary", "Jack", "Quinn"]
print(names2[0])
print(names2[3])

func setName(to newName: String) {
    precondition(newName.isEmpty == false, "Name must not be empty")
    print("Name is now \(newName)")
}

func squareRoot(of number: Double) -> Double {
    precondition(number >= 0, "Number must not be negative")
    return sqrt(number)
}

let names3 = ["Gary", "Jack", "Quinn"]
print(names3[0])
print(names3[3])

extension Array {
    subscript(safe idx: Int) -> Element? {
        if idx >= 0 && idx < count {
            return self[idx]
        } else {
            return nil
        }
    }
}

if let name = names3[safe: 3] {
    print(name)
} else {
    print("Name not found.")
}

extension Array {
    subscript(idx: Int, default default: Element) -> Element {
        if idx >= 0 && idx < count {
            return self[idx]
        } else {
            return `default`
        }
    }
}

print(names3[3, default: "Anonymous"])
