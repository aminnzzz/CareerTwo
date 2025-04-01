import Foundation

//Runtime reflection with Mirror

/*
 What happens if we have only part of the information about a type, either because we have Any or because we’re dealing with a protocol that defines only a subset of the object’s data.
 If we have lots of properties we want to print, do you really want to read them out one by one?
 What happens if we add more properties to the type later on – will we remember to adjust our code to add them?
 */
struct Bus: Decodable, Identifiable {
    var id: Int
    var name: String
    var location: String
    var destination: String
}

let bus: Bus = .init(id: 1, name: "City Bus", location: "Main Street", destination: "University")

let mirror = Mirror(reflecting: bus)

for child in mirror.children {
//    guard let value = child.value as? String else { continue }
    print("\(child.label ?? "<unnamed>") : \(child.value)")
}

//var filteredBuses: [Bus] {
//    if searchText.isEmpty {
//        return buses
//    } else {
//        return buses.filter { bus in
//            bus.name.localizedCaseInsensitiveContains(searchText) ||
//            bus.location.localizedCaseInsensitiveContains(searchText) ||
//            bus.destination.localizedCaseInsensitiveContains(searchText)
//        }
//    }
//}

//var filteredBuses: [Bus] {
//    if searchText.isEmpty {
//        return buses
//    } else {
//        return buses.filter { bus in
//            let mirror = Mirror(reflecting: bus)
//
//            for child in mirror.children {
//                guard let value = child.value as? String else { continue }
//                if value.localizedCaseInsensitiveContains(searchText) {
//                    return true
//                }
//            }
//
//            return false
//        }
//    }
//}

func ~=(lhs: Any, rhs: String) -> Bool {
    let mirror = Mirror(reflecting: lhs)

    for child in mirror.children {
        if let value = child.value as? String {
            if value.localizedCaseInsensitiveContains(rhs) {
                return true
            }
        }
    }

    return false
}

//var filteredBuses: [Bus] {
//    if searchText.isEmpty {
//        return buses
//    } else {
//        return buses.filter { bus in
//            bus ~= searchText
//        }
//    }
//}

func mirror(_ value: Any, using function: (Any) -> Void) {
    let mirror = Mirror(reflecting: value)

    for child in mirror.children {
        function(child.value)
    }
}

let data = (1, 2, 3)

mirror(data) { value in
    print(value)
}

protocol Searchable {
    var keyPaths: [KeyPath<Self, String>] { get }
}

extension Searchable {
    func matches(_ searchString: String) -> Bool {
        for path in keyPaths {
            let value = self[keyPath: path]

            if value.localizedCaseInsensitiveContains(searchString) {
                return true
            }
        }

        return false
    }
}

extension Sequence where Element: Searchable {
    func fuzzyFilter(for searchString: String) -> [Element] {
        filter { $0.matches(searchString) }
    }
}

struct BusV2: Decodable, Identifiable, Searchable {
    enum CodingKeys: CodingKey {
        case id, name, location, destination
    }

    var id: Int
    var name: String
    var location: String
    var destination: String

    var keyPaths: [KeyPath<BusV2, String>] = [\.name, \.location, \.destination]
}
//
//var filteredBuses: [Bus] {
//    if searchText.isEmpty {
//        return buses
//    } else {
//        return buses.fuzzyFilter(for: searchText)
//    }
//}

/*
 still very fast, not as fast as reading properties directly though
 swiftUI uses reflection to reach child views of HStacks and etc
 */

//Printing vs dumping

enum Position {
    case goal, defence, midfield, attack
}

struct Club {
    var name: String

    init(name: String) {
        self.name = name
    }
}

struct Footballer {
    var name: String
    var club: Club
    var position: Position

    init(name: String, club: Club, position: Position) {
        self.name = name
        self.club = club
        self.position = position
    }
}

let richmond = Club(name: "AFC Richmond")
let roy = Footballer(name: "Roy Kent", club: richmond, position: .midfield)
print(roy)

print(1...10)
dump(1...10)

let names = ["Taylor", "Justin", "Adele"]
print(names)
dump(names)

let numbers = IndexSet([1, 2, 3, 5, 7, 9])
print(numbers)
dump(numbers)

dump(roy, name: "Roy")

dump(roy, name: "Roy", maxDepth: 2, maxItems: 4)

class Logger: TextOutputStream {
    private let fileHandle: FileHandle

    init(url: URL) throws {
        let fm = FileManager.default
        let path = url.path()

        if fm.fileExists(atPath: path) == false {
            fm.createFile(atPath: path, contents: nil)
        }

        fileHandle = try FileHandle(forWritingTo: url)
        try fileHandle.seekToEnd()
    }

    func write(_ string: String) {
        let data = Data(string.utf8)
        fileHandle.write(data)
    }

    deinit {
        try? fileHandle.close()
    }
}

let url = URL.homeDirectory.appending(path: "output.log")
var logger = try Logger(url: url)
dump(roy, to: &logger, name: "Roy", maxDepth: 2, maxItems: 4)
