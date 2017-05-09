//
//  User+CoreDataProperties.swift
//  Alzheimer Care
//
//  Created by Student on 5/9/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var picture: ProfilePicture?

}
