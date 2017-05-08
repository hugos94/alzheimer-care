//
//  Audio.swift
//  Alzheimer Care
//
//  Created by Student on 08/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import Foundation

class Memory {
    let name: String
    let date: Date
    var audio: String
    
    init(name: String, date: Date, audio: String) {
        self.name = name
        self.date = date
        self.audio = audio
    }
}
