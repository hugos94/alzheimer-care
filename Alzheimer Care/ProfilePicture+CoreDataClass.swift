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
  }
  
  convenience init(_ imageData: NSData, _ user: User) {
    self.init()
    
    self.imageData = imageData
    self.user = user
    user.picture = self
  }
}
