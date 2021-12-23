//
//  ProfileViewModel.swift
//  Instagram
//
//  Created by 장선영 on 2021/11/25.
//

import Foundation
import Firebase

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsfollowed()
    }
    
    // follow
    // Unfollow
    
    func follow() {
        guard let uid = user.id else { return }
        UserService.follow(uid: uid) { _ in
            self.user.isFollowed = true
            print("팔로우 성공")
        }
        
//        guard uid =  else {
//            <#statements#>
//        }
        // 내가 누군지 알아야 함 -> guard uid
        // Firebase의 특정 API 사용 -> 관계형DB 사용 못함 -> NoSQL을 관계형으로
            // A가 B를 팔로우 한다는 사실을 Firebase에 저장
            // A를 저장할 곳
            // B를 저장할 곳
        print("팔로우")
    }
    
    func unfollow() {
        guard let uid = user.id else { return }
        UserService.unfollow(uid: uid) { _ in
            self.user.isFollowed = false
            print("언팔로우 성공")
        }
    }
    
    func checkIfUserIsfollowed() {
        guard !user.isCurrentUser else { return }
        
        guard let uid = user.id else { return }
        UserService.checkIfUserIfFollowed(uid: uid) { isFollowed in
            self.user.isFollowed = isFollowed
        }
    }
    
}
