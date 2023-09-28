//
//  ViewController.swift
//  InstaClone
//
//  Created by umut yalçın on 25.09.2023.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavBar()
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavBar(){
        
        let image = UIImage(named: "logo")?.withTintColor(.systemBackground)
        let icon = UIImage(named: "message")?.withTintColor(.systemBackground)
                
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: nil)

                
        navigationItem.rightBarButtonItems = [
            
            
            UIBarButtonItem(image: icon, style: .done, target: self, action: nil),
                    
            UIBarButtonItem(image: UIImage(systemName: "heart",withConfiguration: UIImage.SymbolConfiguration(weight: .medium)), style: .done, target: self, action: nil),
        ]
            
        navigationController?.navigationBar.tintColor = .label
    }
}



