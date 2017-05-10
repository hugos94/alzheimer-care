//
//  UserDAO.swift
//  Alzheimer Care
//
//  Created by Student on 5/10/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData

public class UserDAO: DataAccessObject {
  public typealias E = User
  
  public static func create(_ entity: User) -> Bool {
    return DataManager.insert(entity)
  }
  
  public static func read() -> [User] {
    var users = [User]()
    
    let req: NSFetchRequest<User> = User.fetchRequest()
    req.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    
    do {
      try users = DataManager.context.fetch(req)
    } catch let error {
      print("Something bad happened: \(error.localizedDescription)")
    }
    
    return users
  }
  
  public static func delete(_ entity: User) -> Bool {
    return DataManager.delete(entity)
  }
}
