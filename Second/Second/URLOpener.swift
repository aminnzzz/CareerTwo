//
//  URLOpener.swift
//  Second
//
//  Created by amin nazemzadeh on 8/1/25.
//

import SwiftUI

protocol ApplicationProtocol {
    func open(
        _ url: URL,
        options: [UIApplication.OpenExternalURLOptionsKey: Any],
        completionHandler completion: (@MainActor @Sendable (Bool) -> Void)?
    )
}

extension UIApplication: ApplicationProtocol { }

struct URLOpener {
    typealias URLOpening = (URL, [UIApplication.OpenExternalURLOptionsKey: Any], ((Bool) -> Void)?) -> Void
    let open: URLOpening = UIApplication.shared.open

    func open(url: URL) {
        if url.absoluteString.starts(with: "internal://") {
            // run some app-specific code
        } else {
            open(url, [:], nil)
        }
    }
}
