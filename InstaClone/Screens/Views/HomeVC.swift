//
//  ViewController.swift
//  InstaClone
//
//  Created by umut yalçın on 25.09.2023.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {

    private let tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavBar()
    }
    
    func configure(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.bottom.top.equalToSuperview()
        }
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



extension HomeVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
}
