//
//  MemoryDAO.swift
//  Alzheimer Care
//
//  Created by Student on 08/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData

class MemoryDAO {
    
    static private let dateFormatter = DateFormatter()
    
    // ADD
    static func insertion(memory: Memory) -> Bool {
        return DataManager.insert(memory)
    }
    
    // REMOVE
    static func delete(memory: Memory) -> Bool {
        return DataManager.delete(memory)
    }
    
    // SEARCH
    static func getMemories() -> [Memory] {
        var memories = [Memory]()
        
        let request: NSFetchRequest<Memory> = Memory.fetchRequest()
        
        request.sortDescriptors = [
            //NSSortDescriptor(key: "name", ascending: true),
            NSSortDescriptor(key: "name", ascending: true)
        ]
        
        // NSPredicate Cheatsheets
        // Criar predicados para refinar a busca
        // request.predicate = NSPredicate(format: "year == %@", 1999)
        
        do{
            try memories = DataManager.persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Erro ao buscar: \(error.localizedDescription)")
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
