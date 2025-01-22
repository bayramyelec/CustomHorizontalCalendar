//
//  HomeViewModel.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 22.01.2025.
//

import Foundation

class HomeViewModel {
    
    var currentWeek: [Date] = []
    var currentDay: Date = Date() {
        didSet {
            filteredTasks()
        }
    }
    
    var taskList: [Task] = [
        Task(taskTitle: "Finish SwiftUI Pomodoro Timer", taskDescription: "Complete the Pomodoro Timer feature with a countdown circle, start/stop buttons, and integrate a picker for work and break times.", taskDate: Date(), taskColor: .blue),
        Task(taskTitle: "Fix Firebase Data Fetching", taskDescription: "Resolve the issue with fetching data from Firestore and ensure that the list displays correctly with the appropriate user details.", taskDate: Date(), taskColor: .red),
        Task(taskTitle: "Create User Profile Screen", taskDescription: "Design a user profile screen where users can upload and view their photos, edit their information, and save changes to Firestore.", taskDate: Date(), taskColor: .green),
        Task(taskTitle: "Set Up Notifications for New Posts", taskDescription: "Implement push notifications for new posts in the app, so users are notified when a new post is shared.", taskDate: Date(), taskColor: .brown),
        Task(taskTitle: "Improve App UI", taskDescription: "Enhance the user interface by adjusting button styles, adding animations, and making the app more visually appealing.", taskDate: Date(), taskColor: .orange)
    ]
    
    var filteredList: [Task] = []
    
    init () {
        fetchCurrentWeek()
        filteredTasks()
    }
    
    func fetchCurrentWeek () {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else { return }
        (1...7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekDay)
            }
        }
    }
    
    func formattedDate (date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func isToday (date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func filteredTasks(){
        filteredList = taskList.filter { Calendar.current.isDate($0.taskDate, inSameDayAs: currentDay) }
    }
    
}
