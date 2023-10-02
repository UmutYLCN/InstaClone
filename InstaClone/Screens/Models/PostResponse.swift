//
//  PostResponse.swift
//  InstaClone
//
//  Created by umut yalçın on 30.09.2023.
//

import Foundation


struct PostsResponse : Codable {
    
    let results : [Post]
}


struct Post : Codable {
    let imageUrl : String
    let likes : Int
    let postComment : String
    let postedBy : String
}
