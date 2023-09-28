//
//  MainTabBarController.swift
//  InstaClone
//
//  Created by umut yalçın on 26.09.2023.
//

import UIKit
import Firebase


class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            presentLoginController()
            
        } else {
            configureController()

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
    
    func configureController(){
        
        let vc1 = templateNavController(unselectedImage: UIImage(systemName: "house")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "house.fill")!.withTintColor(.label, renderingMode: .alwaysOriginal), rootViewController: HomeVC())
        
    
        let configSearch = UIImage.SymbolConfiguration(weight: .bold)
        let vc2 = templateNavController(unselectedImage: UIImage(systemName: "magnifyingglass")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: configSearch)!.withTintColor(.label, renderingMode: .alwaysOriginal), rootViewController: SearchVC())
        
        
        let vc3 = templateNavController(unselectedImage: UIImage(systemName: "plus.app")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "plus.app")!.withTintColor(.label, renderingMode: .alwaysOriginal),rootViewController: addPostVC())
        
    
        let reelsImage = UIImage(named: "reelsIcon")!.withTintColor(.label, renderingMode: .alwaysOriginal)
        
        let reelsHover = UIImage(named: "reelsHover")!
        reelsHover.withTintColor(.label)
        reelsHover.withRenderingMode(.alwaysTemplate)
        
        let vc4 = templateNavController(unselectedImage: reelsImage, selectedImage: reelsHover , rootViewController: reelsVC())
        
        let vc5 = templateNavController(unselectedImage: UIImage(systemName: "person")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "person.fill")!.withTintColor(.label, renderingMode: .alwaysOriginal), rootViewController: profileVC())
        
        
        
           
        tabBar.tintColor = .label
           
           setViewControllers([vc1,vc2,vc3,vc4,vc5], animated: true)
       }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }

}
