//
//  ActivitiesViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 07/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController{
    
    @IBOutlet weak var physicalActivitiesButton: UIButton!
    @IBOutlet weak var othersActivitiesButton: UIButton!
    @IBOutlet weak var cognitiveActivitiesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonBorder(button: physicalActivitiesButton)
        addButtonBorder(button: othersActivitiesButton)
        addButtonBorder(button: cognitiveActivitiesButton)

    }
    
    private func addButtonBorder (button: UIButton) {
        button.backgroundColor = .clear
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
    }
}
