//
//  ShareViewController.swift
//  Second
//
//  Created by amin nazemzadeh on 7/31/25.
//

import UIKit

class ShareViewController: UIViewController {
    override func loadView() {
        view = ShareView2 { [weak self] in
            self?.shareContent(text: $0)
        }
    }

    func shareContent(text: String) {
        print("Sharing text…")
    }
}
