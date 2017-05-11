//
//  MemoryTableViewCell.swift
//  Alzheimer Care
//
//  Created by Student on 08/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit

class MemoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var memoryNameLabel: UILabel!
    @IBOutlet weak var memoryDateLabel: UILabel!
    @IBOutlet weak var memoryPlayButton: UIButton!
    
    var onButtonTapped : (() -> Void)? = nil
    
    @IBAction func playButton(_ sender: UIButton) {
        print(sender.tag)
        print(memoryNameLabel.text ?? "Deu erro hein!")
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
    
}
