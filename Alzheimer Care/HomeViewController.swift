//
//  HomeViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 05/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var initialInformationTextView: UITextView!
    
    // MARK: - Actions
    
    @IBAction func makeEmergencyCall(_ sender: Any) {
        
        let phoneNumber = UserDefaults.standard.string(forKey: "USER_NUMBER")
        
        print("Ligando para \(phoneNumber!)!")
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber!)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    // MARK: - System Functions
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.string(forKey: "USER_NUMBER") == nil || UserDefaults.standard.string(forKey: "USER_NUMBER") == "" || UserDefaults.standard.string(forKey: "USER_NAME") == nil || UserDefaults.standard.string(forKey: "USER_NAME") == "" {
            performSegue(withIdentifier: "registerSegue", sender: self)
        } else {
            if let name = UserDefaults.standard.string(forKey: "USER_NAME") {
                initialInformationTextView.text = "Olá, \(name)!"
            }
        }
    }

}
