//
//  User+CoreDataClass.swift
//  Alzheimer Care
//
//  Created by Student on 5/9/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData


public class User: NSManagedObject {
    
    public static let entityName = "User"
    
    convenience init() {
        let context = DataManager.context
        let entity = NSEntityDescription.entity(forEntityName: User.entityName, in: context)!
        
        self.init(entity: entity, insertInto: context)
    }
    
    convenience init(_ name: String, _ phone: String, _ image: NSData) {
        let context = DataManager.context
        let entity = NSEntityDescription.entity(forEntityName: User.entityName, in: context)!
        
        self.init(entity: entity, insertInto: context)
        
        print("----- User Coredata inicializado")
        
        self.name = name
        self.phone = phone
        self.imageData = image
    }
}
