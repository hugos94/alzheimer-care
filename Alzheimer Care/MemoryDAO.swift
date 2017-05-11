//
//  MemoryDAO.swift
//  Alzheimer Care
//
//  Created by Student on 08/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData

class MemoryDAO: DataAccessObject {
    public typealias E = Memory
    static private let dateFormatter = DateFormatter()
    
    public static func create(_ entity: Memory) -> Bool {
        return DataManager.insert(entity)
    }
    
    public static func delete(_ entity: Memory) -> Bool {
        return DataManager.delete(entity)
    }
    
    public static func read() -> [Memory] {
        var memories = [Memory]()
        
        let req: NSFetchRequest<Memory> = Memory.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            try memories = DataManager.context.fetch(req)
        } catch let error {
            print("Something bad happened: \(error.localizedDescription)")
        }
        
        return memories
    }
    
    static func getFormattedData(date: Date) -> String {
        return "\(getWeekDay(date)), \(getDay(date)) de \(getMonth(date)) de \(getYear(date)) - \(getTime(date))"
        
    }
    
    static private func getTime(_ date: Date) -> String {
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    static private func getDay(_ date: Date) -> String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date )
    }
    
    static private func getYear(_ date: Date) -> String {
        dateFormatter.dateFormat = "yyy"
        return dateFormatter.string(from: date )
    }
    
    static private func getMonth(_ date: Date) -> String {
        dateFormatter.dateFormat = "MMM"
        let month = dateFormatter.string(from: date )
        return Dictionaries.month[month]!
    }
    
    static private func getWeekDay(_ date: Date) -> String {
        dateFormatter.dateFormat = "EEE"
        let weekDay = dateFormatter.string(from: date )
        return Dictionaries.weekDay[weekDay]!
    }
}
