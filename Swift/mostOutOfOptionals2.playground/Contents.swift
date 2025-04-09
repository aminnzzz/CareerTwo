import UIKit

let username: String? = nil
print(username.unsafelyUnwrapped)


func reverse(_ string: String) -> String {
    String(string.reversed())
}

func reverse(_ string: String?) -> String? {
    if let string = string {
        return String(string.reversed())
    } else {
        return nil
    }
}

func reverse2(_ string: String?) -> String? {
    string.map { String($0.reversed()) }
}

let names = ["Cheetah", "Puma", "Jaguar", "Panther"]
let first = names.first?.map { "The first version of macOS was \($0)" }

let scores = ["100", "80", "85"]
let latestScore = scores.last.map(Int.init)
print(latestScore)

let latestScore2 = scores.last.flatMap(Int.init)


enum Optional<Wrapped>: ExpressibleByNilLiteral {
    case none
    case some(Wrapped)
}

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

extension Result {
    func getOptional() -> Success? {
        switch self {
        case let .success(success):
            return success
        case .failure:
            return nil
        }
    }
}

infix operator !!: NilCoalescingPrecedence

extension Optional {
    public static func !!(optional: Optional, error: String) -> Wrapped {
        guard let wrapped = optional else { fatalError(error) }
        return wrapped
    }
}

extension Optional {
    public static func !!(
        optional: Optional,
        errorMessage: @autoclosure () -> String
    ) -> Wrapped {
        guard let wrapped = optional else { fatalError(errorMessage()) }
        return wrapped
    }
}
