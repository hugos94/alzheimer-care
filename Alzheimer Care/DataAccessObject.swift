//
//  DAO.swift
//  Alzheimer Care
//
//  Created by Student on 5/10/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation

public protocol DataAccessObject {
    associatedtype E
    
    static func create(_ entity: E) -> Bool
    static func read() -> [E]
    static func delete(_ entity: E) -> Bool
}
