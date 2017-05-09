//
//  RegisterViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 05/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var userPhotoImageView: UIImageView!
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var userNumberTextField: UITextField!
  
  // capturador / carregador de imagem
  let imagePicker = UIImagePickerController()
  
  let context = DataManager.context
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    self.setupImagePicker()
  }
  
  // MARK: - Actions
  
  @IBAction func capture(_ sender: Any) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePicker.allowsEditing = false
      imagePicker.sourceType = UIImagePickerControllerSourceType.camera
      imagePicker.cameraCaptureMode = .photo
      imagePicker.modalPresentationStyle = .fullScreen
      present(imagePicker, animated: true, completion: nil)
    } else {
      let alert = UIAlertController(title: "Sem câmera", message: "Desculpe, esse dispositivo não tem câmera", preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      present(alert, animated: true, completion: nil)
    }
  }
  
  @IBAction func load(_ sender: Any) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    present(imagePicker, animated: true, completion: nil)
  }
  
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
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func setupImagePicker() {
    self.imagePicker.delegate = self
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    picker.dismiss(animated: true, completion: nil)
    if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
      userPhotoImageView.contentMode = .scaleAspectFit
      userPhotoImageView.image = pickedImage
    } else if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      userPhotoImageView.contentMode = .scaleAspectFit
      userPhotoImageView.image = pickedImage
    } else {
      print("Failed to convert image for some reason")
    }
    //dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
}
