//
//  ProfileView.swift
//  Instagram
//
//  Created by Sangkon Han on 2021/09/30.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    // A가 변하면? B에서 알아차릴 수 있을까? => @binding
    // A가 변하면? A에서 알아차릴 수 있을까? => @state
    // 데이터 변경 관심 없이 그냥 데이터 넘겨 받기
    
    @ObservedObject var viewModel: ProfileViewModel
    
    init(user: User) {
        self.user = user
        self.viewModel = ProfileViewModel(user: user)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ProfileHeaderView(viewModel: viewModel)
//                ProfileHeaderView(user: user)
                PostGridView()
            }
        }.padding(.top)
    }
}
 
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
