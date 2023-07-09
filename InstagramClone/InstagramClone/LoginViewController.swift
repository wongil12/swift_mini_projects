//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by Bob on 2022/11/27.
//

import UIKit

class LoginViewController: UIViewController {
    
    var email = String()
    var password = String()
    var userInfo: UserInfo? = UserInfo(email: "bob.kim@mvlchain.io", name: "wongil", nickname: "wongil", password: "1q2w3e4R!")

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
    }
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.email = text
        validateLoginField()
    }
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.password = text
        validateLoginField()
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        guard let userInfo = self.userInfo else { return }
        
        if userInfo.email == self.email && userInfo.password == self.password {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        // ARC 관련 공부
        registerViewController.userInfo = { [weak self] userInfo in
            self?.userInfo = userInfo
        }
    }
    
    private func validateLoginField() {
        let isValid = self.email.isValidEmail() && self.password.count > 0
        self.loginButton.backgroundColor = isValid ? .facebookColor : .disabledButtonColor
        self.loginButton.isEnabled = isValid
    }
    
    private func setupAttribute() {
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.registerButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
}
