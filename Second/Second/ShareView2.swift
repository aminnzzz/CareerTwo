//
//  ShareView2.swift
//  Second
//
//  Created by amin nazemzadeh on 7/31/25.
//

import UIKit

class ShareView2: UIView {
    var shareAction: (String) -> Void
    var textField: UITextField!

    init(shareAction: @escaping (String) -> Void) {
        self.shareAction = shareAction
        super.init(frame: .zero)

        let textField = UITextField()
//        textField.sizeAndPositionHoweverYouWant()
        addSubview(textField)

        let button = UIButton(type: .system)
//        button.sizeAndPositionHoweverYouWant()
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        addSubview(button)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported.")
    }

    @objc func shareTapped() {
        guard let text = textField.text else {
            return
        }

        shareAction(text)
    }
}
