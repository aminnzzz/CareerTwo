import UIKit

extension URL {
    init(_ string: StaticString) {
        if let url = URL(string: "\(string)") {
            self = url
        } else {
            fatalError("Illegal URL: \(string)")
        }
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: StaticString) {
        do {
            try self.init(pattern: "\(pattern)")
        } catch {
            preconditionFailure("Illegal regex: \(pattern).")
        }
    }
}
