//
//  User.swift
//  Instagram
//
//  Created by 장선영 on 2021/11/18.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let email: String
    let fullname: String
    let profileImageURL: String
    
    
    var isFollowed : Bool? = false
    var isCurrentUser: Bool {
        return AuthViewModel.shared.userSession?.uid == id
    }
}



//
//struct User: Identifiable, Decodable {
//    @DocumentID var id: String?
//    
//    // > 우선순위대로 배치 / 순서 상관 없음
//    let uid: String
//    let username: String
//    let email: String
//    let fullName: String
//    let profileImageURL: String
//    
//}

//결과: ["email": john1@test.com, "uid": HuhVYPVJwmhCQ3avGyG6X4TXU2t2, "fullname": john1, "profileImageURL": https://firebasestorage.googleapis.com:443/v0/b/instagram-sy-d01ce.appspot.com/o/profile_images%2F0B20ACCA-0417-4488-AB30-2CB6A3F15436?alt=media&token=f6bbe0d2-da20-4cc8-b2fd-fa2816f9afd3, "username": john1]

