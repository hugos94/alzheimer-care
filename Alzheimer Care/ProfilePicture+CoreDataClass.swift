//
//  ProfilePicture+CoreDataClass.swift
//  Alzheimer Care
//
//  Created by Student on 5/9/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData


public class ProfilePicture: NSManagedObject {
  public static let entityName = "ProfilePicture"
  
  convenience init() {
    let context = DataManager.context
    let entity = NSEntityDescription.entity(forEntityName: ProfilePicture.entityName, in: context)!
    
    self.init(entity: entity, insertInto: context)
    print("----- ProfilePicture Coredata inicializado")
  }
  
  convenience init(_ imageData: NSData) {
    let context = DataManager.context
    let entity = NSEntityDescription.entity(forEntityName: ProfilePicture.entityName, in: context)!
    
    self.init(entity: entity, insertInto: context)
    
    self.imageData = imageData
  }
}
