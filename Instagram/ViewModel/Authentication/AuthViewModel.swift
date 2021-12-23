//
//  AuthViewModel.swift
//  Instagram
//
//  Created by 장선영 on 2021/11/04.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func login(withEmail email: String, password: String) {
        
        // > 로그인 로직
        // 1. 이메일, 패스워드 받아오기
        // 2. 이메일, 패스워드를 서버에 전송
        //      - 서버에서는 반드시 '결과, 에러'를 함께 전달
        //          - 에러 발생시 "종료"
        //          - 결과 "확인" 후 "userSession에 user 할당"
        
        // 서버에 "응답"을 "요구" (결과와 에러)를 함께 주세요
        
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("에러 : 사용자 로그인에 실패하였습니다. \(error.localizedDescription)")
                return
            }
            // 에러가 없어도 guard 문 처리
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
        }
    }
    
    
    func register(withEmail email: String,
                  password: String,
                  image: UIImage?,
                  fullname: String,
                  username: String) {
        
        // 1. 이미지 업로드하면서 <= callback이 있음(비동기)
        // 1-1. 사용자도 같이 등록
        // 1-2. 사용자 등록 정보와 프로필 이미지 경로를 함께 받아옴
        // 1-3. 데이터 베이스에 저장함
        
        guard let image = image else { return }
        ImageUploader.uploadImage(image: image) { imageURL in
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                if let error = error {
                    print("에러: 사용자 등록에 실패하였습니다.\(error.localizedDescription)")
                    return
                }
                
                guard let user = result?.user else { return }
                print("성공: 사용자 등록에 성공하였습니다.")
                
                let data = ["email": email,
                            "username": username,
                            "fullname": fullname,
                            "profileImageURL": imageURL,
                            "uid": user.uid
                ]
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) { _ in
                    print("성공: 사용자 정보를 저장하였습니다.")
                    self.userSession = user
                    
                }
            }
        }
    }
    
    func signOut() {
        
        // 1. 서버에 현재 세션 종료 알림
        // 2. self.userSession 깔끔하게 지워야함
        // > 2번 먼저, 무조건 내부 먼저 처리 해야함. 안에서 -> 밖으로
        
        self.userSession = nil
        try? Auth.auth().signOut()
        print("성공: 로그아웃에 성공하였습니다.")
    }
    
    func fetchUser() {
        
        // 로그인한 사용자의 데이터 정보를 가져오기
        // SELECT * FROM users WHERE 내정보
        
        guard let uid = userSession?.uid else { return }
        // SELECT * FROM users WHERE uid == uid
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
            print("성공: 현재 사용자 정보를 가져왔습니다.")
            print("결과: \(user)")
        }
    
    }
}
