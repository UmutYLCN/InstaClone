//
//  profileVC.swift
//  InstaClone
//
//  Created by umut yalçın on 26.09.2023.
//

import UIKit
import Firebase

class profileVC: UIViewController {

    private let logoutBtn : UIButton = {
       
        let btn = UIButton()
        btn.setTitle("Logout", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setCorner(radius: 5)
        btn.backgroundColor = UIColor(hex: "#3797EF")
        btn.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configure()
        configureNavBar()
    }
    
    private func configureNavBar(){
       
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "umutylcnn_", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem?.setTitleTextAttributes(
            [
                .font : UIFont.systemFont(ofSize: 26,weight: .bold),
                .foregroundColor : UIColor.label,
            
            ], for: .normal)
        
                
        navigationItem.rightBarButtonItems = [
                   
            UIBarButtonItem(image: UIImage(systemName: "text.justify",withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), style: .done, target: self, action: nil),
            
            UIBarButtonItem(image: UIImage(systemName: "plus.app", withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), style: .done, target: self, action: nil),
            
        ]
            
        navigationController?.navigationBar.tintColor = .label
    }
    
    @objc
    func handleLogout(){
        do {
            try Auth.auth().signOut()
            presentLoginController()
        }catch {
            print("Error çıkış yapamadı")
        }
    }
    fileprivate func presentLoginController() {
        DispatchQueue.main.async {
            let loginController = LoginVC()
            let navController = UINavigationController(rootViewController: loginController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
    }
    
    
    func configure(){
        view.backgroundColor = .systemBackground
        view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-150)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
            make.height.equalTo(50)
        }
    }

    

}


extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        if index == 2 {
            let layout = MosiacLayout()
            let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let photoSelectorVC = UINavigationController(rootViewController: photoSelectorController)
            photoSelectorVC.modalPresentationStyle = .fullScreen
            present(photoSelectorVC, animated: true, completion: nil)
            return false
        }
        return true
    }
}
