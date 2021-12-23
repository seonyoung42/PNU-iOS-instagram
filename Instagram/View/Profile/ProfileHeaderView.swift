//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by Sangkon Han on 2021/10/28.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    @ObservedObject var viewModel: ProfileViewModel
//    let user: User
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                KFImage(URL(string:viewModel.user.profileImageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 16) {
                    UserStatView(value: 1, title: "Post")
                    UserStatView(value: 2, title: "Followers")
                    UserStatView(value: 3, title: "Followin")
                }.padding(.trailing, 32)
            }
            
            Text(viewModel.user.fullname)
                .font(.system(size: 15, weight: .semibold))
                .padding([.leading, .top])
            
            Text("Chicago Bulls || NBA Legend Players")
                .font(.system(size: 15))
                .padding(.leading)
                .padding(.top, 1)
            
            HStack {
                Spacer()
                ProfileActionButtonView(viewModel: viewModel)
//                ProfileActionButtonView(isCurrentUser: viewModel.user.isCurrentUser)
                Spacer()
            }.padding(.top)
        }
    }
}

