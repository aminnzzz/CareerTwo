import SwiftUI
import Combine
import Network

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    var isActive = false
    var isExpensive = false
    var isConstrained = false
    var connectionType = NWInterface.InterfaceType.other

    init() {
        monitor.pathUpdateHandler = { path in
            self.isActive = path.status == .satisfied
            self.isExpensive = path.isExpensive
            self.isConstrained = path.isConstrained

            let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
            self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other

            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }

        monitor.start(queue: queue)
    }
}
/*
in scene delegate

let monitor = NetworkMonitor()

let contentView = ContentView().environmentObject(monitor)
*/

struct ContentView: View {
    @EnvironmentObject var network: NetworkMonitor

    var body: some View {
        Text(verbatim: """
        Active: \(network.isActive)
        Expensive: \(network.isExpensive)
        Constrained: \(network.isConstrained)
        """)
    }

    func makeRequest() {
        let config = URLSessionConfiguration.default
        config.allowsExpensiveNetworkAccess = false
        config.allowsConstrainedNetworkAccess = false
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.waitsForConnectivity = true

        let session = URLSession(configuration: config)
        let url = URL(string: "https://www.apple.com")!

        session.dataTask(with: url) { data, response, error in
            print(data)
        }.resume()
    }
}

