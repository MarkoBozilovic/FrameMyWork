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
    static var currentDate = Date()
    static let calendar = Calendar(identifier: .gregorian)
    let monthSymbolsArray = Calendar.current.monthSymbols
    let weekdaySymbolsArray = calendar.shortWeekdaySymbols
    var dateComponents = calendar.dateComponents([.year, .month, .day, .weekday],
                                                 from: currentDate)
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Functions
    
    func getCurrentMonth() -> String {
        "\(monthSymbolsArray[dateComponents.month! - 1])"
    }
    
    func getCurrentYear() -> String {
        "\(dateComponents.year!)"
    }
    
    func getNextMonth() -> String {
        if dateComponents.month! >= 12 {
            dateComponents.year! += 1
            dateComponents.month! = 1
        } else {
            dateComponents.month! += 1
        }
        
        FMWCalendar.currentDate = FMWCalendar.calendar.date(from: dateComponents)!
        return getCurrentMonth()
    }
    
    func getPreviousMonth() -> String {
        if dateComponents.month! <= 1 {
            dateComponents.year! -= 1
            dateComponents.month! = 12
        } else {
            dateComponents.month! -= 1
        }
        
        FMWCalendar.currentDate = FMWCalendar.calendar.date(from: dateComponents)!
        return getCurrentMonth()
    }
    
    private func getFristDayOfMonth() -> String {
        let components = FMWCalendar.calendar.dateComponents([.year, .month],
                                                             from: FMWCalendar.currentDate)
        let weekday = FMWCalendar.calendar.component(.weekday,
                                                     from: FMWCalendar.calendar.date(from: components)! - 1)
        guard weekday < 7 else { return weekdaySymbolsArray[0] }
        
        return weekdaySymbolsArray[weekday]
    }
    
    private func getNumberOfDaysInMonth() -> Int {
        var components = DateComponents()
        components.month = dateComponents.month! + 1
        components.second = -1
        let numberOfDays = FMWCalendar.calendar.component(.day, from: FMWCalendar.calendar.date(from: components)!)
        return numberOfDays
    }
    
    func getArrayOfDaysInMonth() -> [String] {
        let arrayOfDaysInt = Array(1...getNumberOfDaysInMonth())
        var arrayOfDaysString = arrayOfDaysInt.map { "\($0)" }
        
        let firstDay = weekdaySymbolsArray.firstIndex(of: getFristDayOfMonth())
        guard firstDay! > 0 else { return arrayOfDaysString }
        
        for _ in 1...firstDay! {
            arrayOfDaysString.insert("", at: 0)
        }
        
        return arrayOfDaysString
    }
}
