//
//  HomeViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 05/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  let context = DataManager.context
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
    
    if let objIdURL = UserDefaults.standard.url(forKey: "ACTIVE_USER_URL"), let psc = context.persistentStoreCoordinator,
      let objId = psc.managedObjectID(forURIRepresentation: objIdURL), let user = context.object(with: objId) as? User {
      initialInformationTextView.text = "Olá, \(user.name!)!"
    } else {
      NSLog("No active user saved -> entering register view")
      performSegue(withIdentifier: "registerSegue", sender: self)
    }
  }
  
}
