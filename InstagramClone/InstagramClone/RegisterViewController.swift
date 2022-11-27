//
//  RegisterViewController.swift
//  InstagramClone
//
//  Created by Bob on 2022/11/27.
//

import UIKit

class RegisterViewController: UIViewController {
    var isValidEmail = false
    
    var isValidName = false
    
    var isValidNickname = false
    
    var isValidPassword = false
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            print("email")
        case nameTextField:
            print("name")
        case nicknameTextField:
            print("nickname")
        case passwordTextField:
            print("password")
        default:
            fatalError("Missing TextField...")
        }
    }
    
    private func setupTextField() {
        textFields.forEach { tf in tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)}

    }
}
