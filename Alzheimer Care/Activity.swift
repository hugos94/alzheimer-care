//
//  Activity.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 08/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation

class Activity {
    
    let name : String
    let description : String
    var time : String
    var frequency : [DayOfWeek]
    
    init(name : String, description: String, time: String, frequency : [DayOfWeek]){
        self.name = name
        self.description = description
        self.time = time
        self.frequency = frequency
        
    }
    
}
