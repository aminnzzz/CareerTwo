import Foundation
/*
 why the naming format: to see which object is calling the delagate
 why the AnyObject: to use weak to avoid retain cycles
 */
protocol CalendarDelegate: AnyObject {
    func calendar(_ calendar: Calendar, willDisplay year: Int)
    func calendar(_ calendar: Calendar, didSelect date: Date)
    func calendarShouldChangeYear(_ calendar: Calendar) -> Bool
}

protocol ReminderPresenting: AnyObject {
    func yearChanged(to year: Int)
}

class Calendar {
    weak var delegate: (any CalendarDelegate)?
    weak var dataSource: (any CalendarDataSource)?

    var selectedDate = Date.now
    var currentYear = 2024

    func changeDate(to date: Date) {
        selectedDate = date
        delegate?.calendar(self, didSelect: date)

        if let items = dataSource?.calendar(self, eventsFor: date) {
            print("Today's events are…")

            for item in items {
                print(item)
            }
        } else {
            print("You have no events today.")
        }
    }

    func add(event: String) {
        dataSource?.calendar(self, add: event, to: selectedDate)
    }

    func changeYear(to year: Int) {
        if delegate?.calendarShouldChangeYear(self) ?? true {
            delegate?.calendar(self, willDisplay: year)
            currentYear = year
        }
    }
}

protocol CalendarDataSource: AnyObject {
    func calendar(_ calendar: Calendar, eventsFor date: Date) -> [String]
    func calendar(_ calendar: Calendar, add event: String, to date: Date)
}

class RemindersCalendarDataSource: CalendarDataSource {
    func calendar(_ calendar: Calendar, eventsFor date: Date) -> [String] {
        ["Organize sock drawer", "Take over the world"]
    }

    func calendar(_ calendar: Calendar, add event: String, to date: Date) {
        print("You're going to \(event) on \(date).")
    }
}

class RemindersCalendarDelegate: CalendarDelegate {
    weak var parentController: (any ReminderPresenting)?

    func calendarShouldChangeYear(_ calendar: Calendar) -> Bool {
        true
    }

    func calendar(_ calendar: Calendar, willDisplay year: Int) {
        parentController?.yearChanged(to: year)
    }

    func calendar(_ calendar: Calendar, didSelect date: Date) {
        print("You selected \(date)")
    }
}

class Reminders: ReminderPresenting {
    var title = "Year: 2024"
    var calendar = Calendar()

    let calendarDataSource = RemindersCalendarDataSource()
    let calendarDelegate = RemindersCalendarDelegate()

    init() {
        calendar.delegate = calendarDelegate
        calendar.dataSource = calendarDataSource
    }

    func yearChanged(to year: Int) {
        title = "Year: \(year)"
    }
}
