//
//  PowerMonitor.swift
//  Second
//
//  Created by amin nazemzadeh on 8/1/25.
//

import UIKit

@MainActor protocol DeviceProtocol {
    var batteryState: UIDevice.BatteryState { get }
}

extension UIDevice: DeviceProtocol { }

@MainActor
struct PowerMonitor {
    var device: any DeviceProtocol

    func getStatus() -> String {
        if device.batteryState == .unplugged {
            "Power is down"
        } else if device.batteryState == .unknown {
            "Error"
        } else {
            "Power is up"
        }
    }
}
