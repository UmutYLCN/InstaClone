//
//  SignUpVC.swift
//  InstaClone
//
//  Created by umut yalçın on 27.09.2023.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    private let logo : UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "instagramlogo")
        let tintImage = image?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        imageView.image = tintImage
        return imageView
    }()

    private let usernameTextField: UITextField! = {
        let view = UITextField()
        view.placeholder = "Username"
        view.backgroundColor = .secondarySystemBackground
        view.borderStyle = .roundedRect
        view.textColor = .label
        view.toStyledTxtField()
        return view
    }()
    
    private let emailTextField: UITextField! = {
        let view = UITextField()
        view.placeholder = "Email"
        view.backgroundColor = .secondarySystemBackground
        view.borderStyle = .roundedRect
        view.textColor = .label
        view.toStyledTxtField()
        return view
    }()
    
    private let passwordTextField: UITextField! = {
        let view = UITextField()
        view.placeholder = "Password"
        view.backgroundColor = .secondarySystemBackground
        view.borderStyle = .roundedRect
        view.textColor = .label
        view.toStyledTxtField()
        return view
    }()
    
    private let ConfirmPasswordTextfield: UITextField! = {
        let view = UITextField()
        view.placeholder = "Confirm Password"
        view.backgroundColor = .secondarySystemBackground
        view.borderStyle = .roundedRect
        view.textColor = .label
        view.toStyledTxtField()
        return view
    }()
    
    private let SignBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor(hex: "#FFFFFF", alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(hex: "#3797EF", alpha: 1)
        btn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        btn.setCorner(radius: 5)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraint()
        
    }
    @objc
    func handleSignUp() {
        guard let username = usernameTextField.text, !username.isEmpty else { return }
        guard let email = emailTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        guard let confirmPassword = ConfirmPasswordTextfield.text,
              !confirmPassword.isEmpty else {return}
        
        if password == confirmPassword {
            
            Auth.auth().createUser(withEmail: email, password: password) { data, err in
                if err != nil {
                    self.alert(message: "\(String(describing: err?.localizedDescription))", title: "Error")
                }else {
                    
    

                    DispatchQueue.main.async {
                        let tabBarController = MainTabBarController()
                        let navController = UINavigationController(rootViewController: tabBarController)
                        navController.modalPresentationStyle = .fullScreen
                        self.present(navController, animated: true, completion: nil)
                    }
                    
                    self.usernameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.ConfirmPasswordTextfield.text = ""
                    
                }
            }
            
        }else{
            alert(message: "Passwords do not match.")
        }
        
    }

    
    func configureConstraint(){
        view.backgroundColor = .systemBackground
        view.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalTo(view.center.x)
            make.leading.equalTo(100)
        }
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(logo.snp.bottom).offset(60)
            
        }

        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(usernameTextField.snp.bottom).offset(11)
            
        }
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(emailTextField.snp.bottom).offset(11)
            
        }
        
        view.addSubview(ConfirmPasswordTextfield)
        ConfirmPasswordTextfield.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(passwordTextField.snp.bottom).offset(11)
        }
        
        view.addSubview(SignBtn)
        SignBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(ConfirmPasswordTextfield.snp.bottom).offset(40)
        }
    }
}
