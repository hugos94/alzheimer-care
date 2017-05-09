//
//  ProfilePicture+CoreDataProperties.swift
//  Alzheimer Care
//
//  Created by Student on 5/9/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation
import CoreData


extension ProfilePicture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfilePicture> {
        return NSFetchRequest<ProfilePicture>(entityName: "ProfilePicture");
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var user: User?

}
