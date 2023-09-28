//
//  LoginVC.swift
//  InstaClone
//
//  Created by umut yalçın on 25.09.2023.
//
 
import UIKit
import SnapKit
import Firebase

class LoginVC: UIViewController {

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
    
    private let loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.setTitleColor(UIColor(hex: "#FFFFFF", alpha: 1), for: .normal)
        btn.backgroundColor = UIColor(hex: "#3797EF", alpha: 1)
        btn.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        btn.setCorner(radius: 5)
        return btn
    }()
    
    private let forgetPasswordLbL: UILabel = {
        let lbl = UILabel()
        lbl.text = "Forgot password?"
        lbl.textColor = UIColor(hex: "#3797EF")
        return lbl
    }()
    
    let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ",
                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                                                                     NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        button.setAttributedTitle(attributedTitle, for: .normal)
        attributedTitle.append(NSAttributedString(string: "Sign Up.",
                                                  attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                                                               NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    @objc
    func handleShowSignUp(){
        let signUpController = SignUpVC()
        navigationController?.pushViewController(signUpController, animated: true)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureConstraint()
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
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(usernameTextField.snp.bottom).offset(11)
            
        }
        view.addSubview(forgetPasswordLbL)
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(forgetPasswordLbL.snp.bottom).offset(30)
        }
        
        forgetPasswordLbL.snp.makeConstraints { make in
            make.trailing.equalTo(-15)
            make.height.equalTo(20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
        
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.top.equalTo(loginBtn.snp.bottom).offset(30)
            make.leading.equalTo(90)
            make.height.equalTo(20)
        }
        
        
    
    }

    @objc func loginTapped(){
        
        guard let email = usernameTextField.text, !email.isEmpty else { return }
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: email, password: password) { data, err in
                if err != nil {
                    
                    self.alert(message: err?.localizedDescription ?? "Error",title: "Error!")
                }else {
                    DispatchQueue.main.async {
                        let tabBarController = MainTabBarController()
                        let navController = UINavigationController(rootViewController: tabBarController)
                        navController.modalPresentationStyle = .fullScreen
                        self.present(navController, animated: true, completion: nil)
                    }
    
                    self.usernameTextField.text = ""
                    self.passwordTextField.text = ""
                 
                }
            }
            
            
        }else{
            alert(message: "Email/Password alanı boş",title: "Error!")
        }
    }
}
