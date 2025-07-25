//
//  User.swift
//  First
//
//  Created by amin nazemzadeh on 7/14/25.
//

import Foundation

struct User {
    var name: String
    var projects = [Project]()

    var outstandingTasksString: String {
        let totalTasks = projects.map(\.items).joined().count

        if totalTasks == 1 {
            return "1 item"
        } else {
            return "\(totalTasks) items"
        }
    }

    mutating func addProject(_ project: Project) {
        projects.append(project)
    }
}

struct Project {
    var name: String
    var items = [ToDoItem]()

    mutating func addToDoItem(_ item: ToDoItem) {
        items.append(item)
    }
}

struct ToDoItem {
    var name: String
}
