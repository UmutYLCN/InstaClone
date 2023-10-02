//
//  addPostVC.swift
//  InstaClone
//
//  Created by umut yalçın on 26.09.2023.
//

import UIKit
import SnapKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class addPostVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    private let imageview : UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
        
    private let postTitleTextField: UITextField! = {
        let view = UITextField()
        view.placeholder = "Post title"
        view.backgroundColor = .secondarySystemBackground
        view.borderStyle = .roundedRect
        view.textColor = .label
        view.toStyledTxtField()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureNavBar()
        
        imageview.isUserInteractionEnabled = true
        let ges = UITapGestureRecognizer(target: self, action: #selector(tappedImageView))
        imageview.addGestureRecognizer(ges)
    }
    
    @objc
    func tappedImageView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker,animated: true,completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true,completion: nil)
    }

    func configure(){
        
        view.backgroundColor = .systemBackground
        view.addSubview(imageview)
        imageview.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(400)
        }
        
        view.addSubview(postTitleTextField)
        postTitleTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(imageview.snp.bottom).offset(30)
        }
        
    }
    private func configureNavBar(){
       
        
        self.navigationItem.leftBarButtonItems = [
                                          
        UIBarButtonItem(image: UIImage(systemName: "multiply")?
            .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30, weight: .regular))),style: .plain, target: self, action: #selector(handleBackBtnTapped)),
        UIBarButtonItem(title: "Yeni gönderi", style: .plain, target: nil, action: nil)
                                                
        ]
       
        
        navigationItem.leftBarButtonItems?.last?.setTitleTextAttributes(
            [
                .font : UIFont.systemFont(ofSize: 26,weight: .bold),
                .foregroundColor : UIColor.label,
            
            ], for: .normal)
        
    
        navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(systemName: "arrow.forward",withConfiguration: UIImage.SymbolConfiguration(weight: .bold)), style: .done, target: self, action: #selector(handleUploadPost))
                   
            
        navigationController?.navigationBar.tintColor = .label
    }
    
    
    @objc
    func handleUploadPost(){
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        if let data = imageview.image?.jpegData(compressionQuality: 0.5) {
            
            
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data,metadata: nil) { (data, err) in
                if err != nil {
                    print(err?.localizedDescription)
                }else {
                    imageReference.downloadURL { (url ,err) in
                        if err == nil {
                            let imageUrl = url?.absoluteString
                            
                            //Firestore
                            
                            let fsDatabase = Firestore.firestore()
                            
                            var fsReference : DocumentReference? = nil
                            
                            guard let postText = self.postTitleTextField.text else {
                                return
                            }
                            
                            let fsPost = [
                                            "imageUrl" : imageUrl!,
                                            "postedBy" : Auth.auth().currentUser?.email!,
                                            "postComment":postText,
                                            "date": FieldValue.serverTimestamp(),
                                            "likes" : 0
                            ] as [String : Any]
                            
                            
                            fsReference = fsDatabase.collection("Posts").addDocument(data: fsPost,completion: { err in
                                
                                
                                if err != nil {
                                    self.alert(message: err?.localizedDescription ?? "Error", title: "Error!")
                                }else{
                                    self.imageview.image = nil
                                    self.postTitleTextField.text = ""
                                    
                                    self.dismiss(animated: true)
                                    
                
                                }
            
                            })
                        }
                    }
                }
            }
            
        }
        
        
    }
    
    @objc
    func handleBackBtnTapped(){
        self.dismiss(animated: true)
    }
    
}
