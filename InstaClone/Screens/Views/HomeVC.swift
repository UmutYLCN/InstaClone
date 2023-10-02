//
//  ViewController.swift
//  InstaClone
//
//  Created by umut yalçın on 25.09.2023.
//

import UIKit
import SnapKit
import Firebase

class HomeVC: UIViewController {

    private var posts : [Post] = [Post]()
    
    private let tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavBar()
        fetchdata()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        posts = [Post]()
        fetchdata()
    }

    
    func fetchdata(){
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Posts").addSnapshotListener { snapshot, err in
            if err != nil {
                print(err?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                    
                        let postedBy = document.get("postedBy")
                        let postedComment = document.get("postComment")
                        let imageUrl = document.get("imageUrl")
                        let likes = document.get("likes")
                        let date = document.get("date")
                        let result = Post(imageUrl: imageUrl as! String, likes: likes as! Int, postComment: postedComment as! String, postedBy: postedBy as! String, date: Date.now)
                    
                        self.posts.append(result)
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let post = posts[indexPath.row]
        cell.configure(with: PostViewModel(imageUrl: post.imageUrl, postComment: post.postComment, postedBy: post.postedBy))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }
    
}
