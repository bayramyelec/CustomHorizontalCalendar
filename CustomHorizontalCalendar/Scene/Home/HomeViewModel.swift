//
//  HomeViewModel.swift
//  CustomHorizontalCalendar
//
//  Created by Bayram Yeleç on 22.01.2025.
//

import Foundation

class HomeViewModel {
    
    var currentWeek: [Date] = []
    var currentDay: Date = Date()
    
    init () {
        fetchCurrentWeek()
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
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter.string(from: date)
    }
    
    func isToday (date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
}
