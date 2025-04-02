import Foundation

// Make optionals easier

struct User {
    var name: String
}

let users = [
    User(name: "Jack"),
    nil,
    User(name: "Gary"),
    nil,
    User(name: "Quinn")
]

let userNames = users.map(\.?.name)
