//
//  RegisterViewController.swift
//  InstagramClone
//
//  Created by Bob on 2022/11/27.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK - Properties
    // 유효성 검사를 위한 Property
    var isValidEmail = false {
        didSet{
            self.validateUserInfo()
        }
    }
    
    var isValidName = false {
        didSet{
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false {
        didSet{
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false {
        didSet{
            self.validateUserInfo()
        }
    }
    
    // TextFields
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var popToLoginButton: UIButton!
    
    
    var textFields: [UITextField] {
        [emailTextField, nameTextField, nicknameTextField, passwordTextField]
    }
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupAttribute()
    }
    
    // MARK - Actionse
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
        case nameTextField:
            self.isValidName = text.count > 2
        case nicknameTextField:
            self.isValidNickname = text.count > 2
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
        default:
            fatalError("Missing TextField...")
        }
    }
    
    // MARK - Helpers
    private func setupTextField() {
        textFields.forEach { tf in tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)}
    }
    
    private func validateUserInfo() {
        if isValidEmail
            && isValidName
            && isValidNickname
            && isValidPassword {
            self.signupButton.isEnabled = true
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = .facebookColor
            }
        } else {
            self.signupButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signupButton.backgroundColor = .disabledButtonColor
            }
        }
    }
    
    private func setupAttribute() {
        let text1 = "게정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.popToLoginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
    }
}

// Regex
extension String {
    func isValidPassword() -> Bool {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        return passwordValidation.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValidation = NSPredicate.init(format: "SELF MATCHES %@", regex)
        
        return emailValidation.evaluate(with: self)
    }
}

