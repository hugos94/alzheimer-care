//
//  Memory+CoreDataClass.swift
//  Alzheimer Care
//
//  Created by Student on 10/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData


public class Memory: NSManagedObject {
    
    public static let entityName = "Memory"
    
    convenience init() {
        let context = DataManager.context
        let entity = NSEntityDescription.entity(forEntityName: Memory.entityName, in: context)!

        self.init(entity: entity, insertInto: context)
    }

}
