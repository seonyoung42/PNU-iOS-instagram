//
//  InstagramApp.swift
//  Instagram
//
//  Created by 장선영 on 2021/09/30.
//

import SwiftUI
import Firebase

@main
struct InstagramApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            
            // 사용자가 기본적으로 로그인 되어 있다면 ContentView 보여줘야함
            // Default로 로그인 되어 있다고 생각.
            
//            ContentView().environmentObject(AuthViewModel())
            ContentView().environmentObject(AuthViewModel.shared) //AuthviewModel은 실수라도 여러개 만들어지지 않도록 주의 : 싱글톤
            
//            LoginView().environmentObject(AuthViewModel())
        }
    }
}
