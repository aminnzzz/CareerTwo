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
dump(userNames)

for case let user? in users {
    print(user.name)
}

let from = users[0]
let to = users[1]

switch (from, to) {
case let (from?, to?):
    print("Transferring from \(from.name) to \(to.name).")
case let (from?, nil):
    print("Transfer from \(from.name) needs a destination.")
case let (nil, to?):
    print("Transfer to \(to.name) needs a source.")
case (nil, nil):
    print("Transfer is missing both source and destination.")
}
