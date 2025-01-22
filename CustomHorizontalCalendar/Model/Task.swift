//
//  Task.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 22.01.2025.
//

import UIKit

struct Task {
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
    var taskColor: UIColor
}
