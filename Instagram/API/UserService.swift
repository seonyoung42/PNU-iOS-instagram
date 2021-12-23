//
//  UserService.swift
//  Instagram
//
//  Created by 장선영 on 2021/12/02.
//

import Foundation
import Firebase

struct UserService {
    // folloew => id
    static func follow(uid: String, completion: ((Error?)-> Void)?) {
        // 현재 사용자를 알아야함
        // uid : 팔로우하려는 사용자
        // firebase에 팔로우한 것을 저장해야함
        
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore().collection("following").document(currentUid).collection("user-following").document(uid).setData([:]) { _ in
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    
    
    
    // unfollow => id
    static func unfollow(uid: String, completion: ((Error?)-> Void)?) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore().collection("following").document(currentUid).collection("user-following").document(uid).delete() { _ in
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    static func checkIfUserIfFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currendUid = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore().collection("following").document(currendUid).collection("user-following").document(uid).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else {return}
            completion(isFollowed)
        }
    }
}
