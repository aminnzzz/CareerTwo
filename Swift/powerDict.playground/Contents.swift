import UIKit

enum Genre {
    case action, family, fantasy, horror, sciFi
}

struct Movie {
    var name: String
    var genre: Genre
}

let movies = [
    Movie(name: "The Lord of the Rings", genre: .fantasy),
    Movie(name: "The Matrix", genre: .sciFi),
    Movie(name: "Minority Report", genre: .sciFi)
]

let moviesByGenre1 = Dictionary(grouping: movies, by: \.genre)
let moviesByGenre2 = Dictionary(grouping: movies) {
    $0.genre
}
var moviesByName = Dictionary(grouping: movies, by: \.name.first!)

moviesByName["A", default: []] += [
    Movie(name: "Alien", genre: .sciFi),
    Movie(name: "Aliens", genre: .sciFi),
    Movie(name: "Alien³", genre: .sciFi)
]

var favoriteTVShows = ["Red Dwarf", "Blackadder", "Fawlty Towers", "Red Dwarf"]
var favoriteCounts = [String: Int]()

for show in favoriteTVShows {
    favoriteCounts[show, default: 0] += 1
}


let gameHeroes: KeyValuePairs = [
    "Mario": ["Mario Kart", "Super Mario Bros"],
    "Link": ["Breath of the Wild", "Tears of the Kingdom"],
    "Mario": ["Super Mario World", "Super Mario Galaxy"]
]

dump(gameHeroes)

for hero in gameHeroes {
    print("\(hero.key): \(hero.value.formatted(.list(type: .and)))")
}
