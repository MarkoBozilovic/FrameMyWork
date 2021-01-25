//
//  FMWCalendar.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 10.1.21..
//

import Foundation

class FMWCalendar {
    
    // MARK: - Properties
    
    static var shared = FMWCalendar()
    private static var currentDate = Date()
    
    var currentMonth = ""
    var arrayOfDays = [FMWDate]()
    
    
    private let monthSymbols = Calendar.current.monthSymbols
    let weekdaySymbols = Calendar.current.shortWeekdaySymbols
    var dateComponents = Calendar.current.dateComponents([.year,
                                                          .month], from: currentDate)
    
    // MARK: - Init
    
    private init() {
        generateCurrentMonthAndYear()
        generateDays()
    }
    
    // MARK: - Functions
    
    private func numberOfDaysInMonth() -> Int {
        var components = DateComponents()
        components.month = dateComponents.month! + 1
        components.second = -1
        
        let date = Calendar.current.date(from: components)
        
        return Calendar.current.component(.day, from: date!)
    }
    
    private func generateDays() {
        arrayOfDays.removeAll()
        var components = DateComponents()
        components.year = dateComponents.year
        components.month = dateComponents.month
        components.day = 1
        components.hour = 1
        
        for _ in 1...numberOfDaysInMonth() {
            let date = Calendar.current.date(from: components)
            let customDate = FMWDate(date: date!)
            insertSchedules(Model.shared.schedules, for: customDate)
            arrayOfDays.append(customDate)
            components.day! += 1
        }
        
        let firstDayOfMonthInt = weekdaySymbols.firstIndex(of: firstWeekdayOfMonth())!
        for _ in 0...firstDayOfMonthInt {
            arrayOfDays.insert(FMWDate(date: nil), at: 0)
        }
    }
    
    private func insertSchedules(_ schedules: [Schedule]?, for date: FMWDate) {
        guard let schedules = schedules else { return }
        for schedule in schedules {
            if compareDates(date1: schedule.date, date2: date.date!) {
                date.schedule = schedule
                break
            }
        }
    }
    
    private func generateCurrentMonthAndYear() {
        currentMonth = "\(monthSymbols[dateComponents.month! - 1]) \(dateComponents.year!)"
    }
    
    func nextMonth() {
        if dateComponents.month! >= 12 {
            dateComponents.year! += 1
            dateComponents.month! = 1
        } else {
            dateComponents.month! += 1
        }
        generateCurrentMonthAndYear()
        generateDays()
    }
    
    func previousMonth() {
        if dateComponents.month! <= 1 {
            dateComponents.year! -= 1
            dateComponents.month! = 12
        } else {
            dateComponents.month! -= 1
        }
        generateCurrentMonthAndYear()
        generateDays()
    }
    
    private func compareDates(date1: Date, date2: Date) -> Bool {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "d.MM.yy"
        return dateFormater.string(from: date1) == dateFormater.string(from: date2)
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    private func firstWeekdayOfMonth() -> String {
        var components = DateComponents()
        components.year = dateComponents.year
        components.month = dateComponents.month
        let weekday = Calendar.current.component(.weekday, from: Calendar.current.date(from: components)! - 1)
        guard weekday < 7 else { return weekdaySymbols[0] }
        return weekdaySymbols[weekday]
    }
}
