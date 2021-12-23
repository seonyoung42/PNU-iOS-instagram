//
//  SearchViewModel.swift
//  Instagram
//
//  Created by 장선영 on 2021/11/18.
//

import Foundation
import Firebase

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        fetchUser()
    }
    
    func fetchUser() {
        Firestore.firestore().collection("users").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.users = documents.compactMap({ try? $0.data(as: User.self)})
            print("성공: 사용자 정보를 가져왔습니다.\(self.users)")
        }
    }
    
    func filteredUsers(_ query: String) -> [User] {
        let lowercaseQuery = query.lowercased() // 검색은 소문자로 바꿈
        
        return users.filter({
            $0.fullname.lowercased().contains(lowercaseQuery) ||
                $0.username.contains(lowercaseQuery)
        })
    }
    
//    func fetchUser() {
//
//        Firestore.firestore().collection("users").getDocuments { snapshot, _ in
//
//            guard let documents = snapshot?.documents else { return }
//            print(documents)
//            self.users = documents.compactMap({try? $0.data(as: User.self)})
//
//            print("성공: 사용자 정보를 가져왔습니다.")
//            print(self.users)
////            print("결과: \(user)")
//        }
//    
//    }
    
}
