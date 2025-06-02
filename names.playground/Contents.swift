import UIKit

var components = PersonNameComponents()
components.givenName = "Taylor"
components.middleName = "Alison"
components.familyName = "Swift"
components.nickname = "Taytay"

let formatter = PersonNameComponentsFormatter()
let defaultName = formatter.string(from: components)
print(defaultName)

formatter.style = .short
let shortName = formatter.string(from: components)
print(shortName)

formatter.style = .long
let longName = formatter.string(from: components)
print(fullName)

if let paul = formatter.personNameComponents(from: "Paul Hudson") {
    print(paul)
}

if let paul = formatter.personNameComponents(from: "Hudson, Paul") {
    print(paul)
}

if let paul = formatter.personNameComponents(from: "Hudson Paul") {
    print(paul)
}

if let charles = formatter.personNameComponents(from: "Charles Philip Arthur George Mountbatten-Windsor") {
    print(charles)
}

if let adele = formatter.personNameComponents(from: "Adele Laurie Blue Adkins") {
    print(adele)
}


struct MonogramView: View {
    private struct CircledMonogram<Content: View>: View {
        var content: Content

        var body: some View {
            content
                .font(.system(.largeTitle, design: .rounded))
                .padding()
                .background(Color.yellow)
                .clipShape(Circle())
        }
    }

    func makeGenericMonogram() -> some View {
        CircledMonogram(content: Image(systemName: "person.fill"))
    }

    func makePreciseMonogram(for name: String) -> some View {
        CircledMonogram(content: Text(name))
    }

    let name: String

    func makeMonogram() -> some View {
        let formatter = PersonNameComponentsFormatter()

        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            let abbreviatedName = formatter.string(from: components)

            if abbreviatedName.count == 2 {
                return AnyView(makePreciseMonogram(for: abbreviatedName))
            }
        }

        return AnyView(makeGenericMonogram())
    }

    var body: some View {
        makeMonogram()
    }
}



