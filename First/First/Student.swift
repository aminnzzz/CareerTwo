//
//  Student.swift
//  First
//
//  Created by amin nazemzadeh on 7/10/25.
//

import Foundation

struct Student {
    var isAtSchool = false

    mutating func goToSchool() {
        isAtSchool = true
    }

    mutating func leaveSchool() {
        isAtSchool = false
    }
}
