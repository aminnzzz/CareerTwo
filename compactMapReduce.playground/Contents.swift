import UIKit

let numbers = [1, 3, 5]
let sum = numbers.reduce(0, +)

let sum2 = numbers.reduce(0) { previousSum, nextNumber in
    let newSum = previousSum + nextNumber
    return newSum
}

struct Message: Decodable {
    let id: Int
    let user: String
    let text: String
}

func getMessages() async throws -> [Message] {
    try await withThrowingTaskGroup(of: [Message].self) { group -> [Message] in
        for i in 1...3 {
            group.addTask {
                let url = URL(string: "https://hws.dev/inbox-\(i).json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                return try JSONDecoder().decode([Message].self, from: data)
            }
        }

        let allStories = try await group.reduce(into: [Message]()) { $0 += $1 }
        return allStories.sorted { $0.id < $1.id }
    }
}

let inbox = try await getMessages()
print(inbox)
