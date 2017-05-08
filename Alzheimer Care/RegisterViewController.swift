//
//  RegisterViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 05/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNumberTextField: UITextField!
    
    @IBAction func registerButton(_ sender: Any) {
        if userNameTextField.text != "" && userNameTextField.text != nil && userNumberTextField.text != "" && userNumberTextField.text != nil {
            
            UserDefaults.standard.set(userNumberTextField.text, forKey: "USER_NUMBER")
            UserDefaults.standard.set(userNameTextField.text, forKey: "USER_NAME")
            
            dismiss(animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "Erro!", message: "Preencha todos os campos :D", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { action in
                // perhaps use action.title here
            })
            
            self.present(alert, animated: true)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

}
