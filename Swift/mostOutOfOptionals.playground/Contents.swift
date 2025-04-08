import UIKit

struct User {
    var name: String
    var password: String?
}

let amelia = User(name: "Amelia")

struct User2 {
    var name: String
    var password: Optional<String>
}

let amelia2 = User2(name: "Amelia", password: nil)

let newScore: Int? = nil
let maxScore = 50

if newScore == maxScore {
    print("You matched the high score!")
}

struct User3 { }
let a: User3? = User3()
let b: User3? = User3()
print(a == b)

if newScore > maxScore {
    print("You beat the high score!")
}


struct UserV1 {
    var friend: UserV1
}

struct UserV2 {
    var friends: [UserV2]
}

struct UserV3 {
    var friend: UserV3?
}

final class Box<T> {
    var value: T

    init(value: T) {
        self.value = value
    }
}

struct UserVV3 {
    var friend: Box<UserVV3>?
}

enum CustomOptional<Wrapped> {
    case none
    case some(Wrapped)
}

struct User4 {
    var friend: CustomOptional<User4>
}

indirect enum CustomOptional2<Wrapped> {
    case none
    case some(Wrapped)
}

struct UserV4 {
    var friend: CustomOptional2<UserV4>
}
