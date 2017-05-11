//
//  UserDAO.swift
//  Alzheimer Care
//
//  Created by Student on 5/10/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData

public class PictureDAO: DataAccessObject {
  public typealias E = ProfilePicture
  
  public static func create(_ entity: ProfilePicture) -> Bool {
    return DataManager.insert(entity)
  }
  
  public static func read() -> [ProfilePicture] {
    var pictures = [ProfilePicture]()
    
    let req: NSFetchRequest<ProfilePicture> = ProfilePicture.fetchRequest()
    
    do {
      try pictures = DataManager.context.fetch(req)
    } catch let error {
      print("Something bad happened: \(error.localizedDescription)")
    }
    
    return pictures
  }
  
  public static func delete(_ entity: ProfilePicture) -> Bool {
    return DataManager.delete(entity)
  }
}
