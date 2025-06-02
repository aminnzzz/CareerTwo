import UIKit

func loadSettings() {
    let defaults = UserDefaults.standard

    if defaults.bool(forKey: "SettingsSaved") == false {
        defaults.set(true, forKey: "SettingsSaved")
        defaults.set("standard", forKey: "ReadingMode")
        defaults.set(0, forKey: "HighScore")
    }

    // temporary, for launch options mainly
    UserDefaults.standard.register(defaults: [
        "ReadingMode": "standard",
        "HighScore": 0
    ])

    guard let defaults = UserDefaults(suiteName: "group.com.hackingwithswift.userdefaults") else { return }
    // make sure to enable iCloud key/value first
    NSUbiquitousKeyValueStore.default.set("Paul", forKey: "username")
    let username = NSUbiquitousKeyValueStore.default.string(forKey: "username") ?? "Anonymous"

}


extension UserDefaults {
    static var shared: UserDefaults {
        guard let defaults = UserDefaults(suiteName: "group.YOUR_GROUP_IDENTIFIER_HERE") else {
            let defaults = UserDefaults.standard
            defaults.addSuite(named: "group.YOUR_GROUP_IDENTIFIER_HERE")
            return defaults
        }

        return defaults
    }
}

final class CloudDefaults {
    static let shared = CloudDefaults()
    private var ignoreLocalChanges = false

    private init() { }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func start() {
        NotificationCenter.default.addObserver(forName: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default, queue: .main, using: updateLocal)

        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main, using: updateRemote)

        NSUbiquitousKeyValueStore.default.synchronize()
    }

    private func updateRemote(note: Notification) {
        guard ignoreLocalChanges == false else { return }

        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
            guard key.hasPrefix("sync-") else { continue }
            print("Updating remote value of \(key) to \(value)")
            NSUbiquitousKeyValueStore.default.set(value, forKey: key)
        }
    }

    private func updateLocal(note: Notification) {
        ignoreLocalChanges = true

        for (key, value) in NSUbiquitousKeyValueStore.default.dictionaryRepresentation {
            guard key.hasPrefix("sync-") else { continue }
            print("Updating local value of \(key) to \(value)")
            UserDefaults.standard.set(value, forKey: key)
        }

        ignoreLocalChanges = false
    }
}

@propertyWrapper struct UserDefault<T> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

@UserDefault(key: "username", defaultValue: "Anonymous") var username

@UserDefault var username = "Anonymous"

