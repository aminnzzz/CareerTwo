import UIKit

struct Classroom {
    let scores: [Double]
    var credits = 10

    mutating func chargeForCalculatingGrades(normalize: Bool = false) -> [String] {
        if chargeUser() {
            return calculateGrades(normalize: normalize)
        } else {
            return []
        }
    }

    mutating func chargeUser() -> Bool {
        guard credits >= 0 else { return false }
        credits -= 1
        return true
    }

    func calculateGrades(normalize: Bool = false) -> [String] {
        var result = [String]()

        if normalize {
            let highest = scores.max() ?? 100

            for score in scores {
                if score > highest - 5 {
                    result.append("A")
                } else if score > highest - 15 {
                    result.append("B")
                } else if score > highest - 25 {
                    result.append("C")
                } else {
                    result.append("Fail")
                }
            }
        } else {
            for score in scores {
                if score > 95 {
                    result.append("A")
                } else if score > 80 {
                    result.append("B")
                } else if score > 70 {
                    result.append("C")
                } else {
                    result.append("Fail")
                }
            }
        }

        return result
    }
}

var classroom = Classroom(scores: [90, 85, 70, 95, 80])
print(classroom.calculateGrades())
print(classroom.calculateGrades())
print(classroom.calculateGrades())
