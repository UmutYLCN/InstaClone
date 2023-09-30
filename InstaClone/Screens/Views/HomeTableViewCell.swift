//
//  HomeTableViewCell.swift
//  InstaClone
//
//  Created by umut yalçın on 29.09.2023.
//

import UIKit
import SnapKit


class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    private let profilPhoto : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ana")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.label.cgColor
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    
    private let postimageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ana")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let usernameLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "umutylcnn_"
        lbl.font = UIFont.systemFont(ofSize: 26,weight: .semibold)
        lbl.textColor = .label
        return lbl
    }()
    
    private let threeDot : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dots")?.withTintColor(.label)
        return imageView
    }()
    
    private let likeBtn : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let commentBtn : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chat")?.withTintColor(.label)
        return imageView
    }()
    
    private let shareBtn : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "send")?.withTintColor(.label)
        imageView.tintColor = .label
        return imageView
    }()
    
    private let saveBtn : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bookmark")
        imageView.tintColor = .label
        return imageView
    }()
    
    private let detail : UILabel = {
        let lbl = UILabel()
        lbl.text = "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(profilPhoto)
        contentView.addSubview(postimageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(threeDot)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(shareBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(detail)
        applyConstraints()
       }
    
    private func applyConstraints(){
        profilPhoto.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.leading.equalTo(10)
            make.top.equalTo(contentView.snp.top).offset(10)
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profilPhoto.snp.trailing).offset(10)
            make.top.equalTo(contentView.snp.top).offset(18)
        }
        threeDot.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.height.width.equalTo(25)
            make.top.equalTo(contentView.snp.top).offset(22)
        }
        postimageView.snp.makeConstraints { make in
            make.top.equalTo(profilPhoto.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        likeBtn.snp.makeConstraints { make in
            make.top.equalTo(postimageView.snp.bottom).offset(10)
            make.leading.equalTo(10)
            make.width.height.equalTo(35)
        }
        commentBtn.snp.makeConstraints { make in
            make.top.equalTo(postimageView.snp.bottom).offset(13)
            make.leading.equalTo(likeBtn.snp.trailing).offset(20)
            make.width.height.equalTo(29)
        }
        shareBtn.snp.makeConstraints { make in
            make.top.equalTo(postimageView.snp.bottom).offset(13)
            make.width.height.equalTo(29)
            make.leading.equalTo(commentBtn.snp.trailing).offset(20)
        }
        saveBtn.snp.makeConstraints { make in
            
            make.top.equalTo(postimageView.snp.bottom).offset(15)
            make.trailing.equalTo(-15)
            make.width.height.equalTo(29)
            
        }
        detail.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.leading.equalTo(10)
            make.height.equalTo(50)
            make.top.equalTo(likeBtn.snp.bottom).offset(10)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
            fatalError()
    }

}



