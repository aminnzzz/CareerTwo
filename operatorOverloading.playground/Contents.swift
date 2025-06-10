import UIKit

extension CGPoint {
    public static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

extension URL {
    static func +(lhs: URL, rhs: String) -> URL {
        lhs.appendingPathComponent(rhs)
    }
}

extension URL {
    static func +=(lhs: inout URL, rhs: String) {
        lhs.appendPathComponent(rhs)
    }
}

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: rhs.width + rhs.height)
    }
}

extension URL {
    static func / (lhs: URL, rhs: String) -> URL {
        lhs.appendingPathComponent(rhs)
    }
}

extension Double {
    static func ^(lhs: Double, rhs: Double) -> Double {
        pow(lhs, rhs)
    }
}

infix operator **
extension Double {
    static func **(lhs: Double, rhs: Double) -> Double {
        pow(lhs, rhs)
    }
}
