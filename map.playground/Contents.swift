import UIKit

extension Sequence {
    func transformed<NewType>(_ converter: (Element) throws -> NewType) rethrows -> [NewType] {
        var results = [NewType]()
        results.reserveCapacity(self.underestimatedCount)

        for item in self {
            let transformed = try converter(item)
            results.append(transformed)
        }

        return results
    }
}

let squares: [Double] = [4, 9, 16, 25, 36, 49, 64, 81, 100]
let roots = squares.map(sqrt)
print(roots)

func fibonacci(of number: Int) -> Int {
    var first = 0
    var second = 1

    for _ in 0..<number {
        let previous = first
        first = second
        second = previous + first
    }

    return first
}

let first50 = (0..<50).map(fibonacci)
print(first50)

let names = ["Taylor", "Justin", "Adele"]
let nameCounts1 = names.map { name in
    name.count
}
print(nameCounts1)

let nameCounts2 = names.map(\.count)
print(nameCounts2)

//enum Optional<Wrapped> {
//    case none
//    case some(Wrapped)
//}
//
//enum Result<Success, Failure: Error> {
//    case success(Success)
//    case failure(Failure)
//}

func getSavedData() -> Data? {
    Data("Saved data goes here".utf8)
}

let saved = getSavedData().map { data in
    String(decoding: data, as: UTF8.self)
}

let saved2 = getSavedData().map { data in
    String(decoding: data, as: UTF8.self)
} ?? ""

func getSavedData() -> Result<Data, Error> {
    .success(Data("Saved data goes here".utf8))
}

let scores = [100, 80, 85]
let mappedScores = scores.map { $0 }
print(scores == mappedScores)

func uppercased(_ string: String) -> String {
    string.uppercased()
}

func reversed(_ str: String) -> String {
    String(str.reversed())
}

func uppercasedAndReversed(_ str: String) -> String {
    String(str.uppercased().reversed())
}

let names1 = names.map(uppercased).map(reversed)
let names2 = names.map(uppercasedAndReversed)
print(names1 == names2)
