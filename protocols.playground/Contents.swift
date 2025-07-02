import UIKit

protocol CalendarDelegate {
    func calendar(_ calendar: Calendar, willDisplay year: Int)
    func calendar(_ calendar: Calendar, didSelect date: Date)
}

protocol MoviePlayerDelegate {
    func movieDidLoad()
    func movieShouldPause() -> Bool
    func movieWillEnd()
}

extension MoviePlayerDelegate {
    func movieDidLoad() { }
    func movieWillEnd() { }
}

@objc protocol MoviePlayerDelegate {
    @objc optional func movieShouldPause() -> Bool
    func movieWillEnd()
}

struct MoviePlayer {
    var delegate: (any MoviePlayerDelegate)?

    func pausePressed() -> Bool {
        delegate?.movieShouldPause?() ?? true
    }
}

protocol ListDelegate: AnyObject {
    func item(_ item: String, didUpdate quantity: Int)
}

class ItemDetailController {
    weak var delegate: (any ListDelegate)?
}

protocol Payable { }
protocol NeedsTraining { }
protocol HasRestTime { }
protocol Employee: Payable, NeedsTraining, HasRestTime { }

protocol CustomIdentifiable {
    associatedtype IDType
    var id: IDType { get set }
}

struct Person: CustomIdentifiable {
    typealias IDType = String
    var id: String
}

struct WebPage: CustomIdentifiable {
    var id: URL
}
