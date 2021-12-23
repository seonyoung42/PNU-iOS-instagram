//
//  MainTabView.swift
//  Instagram
//
//  Created by Sangkon Han on 2021/09/30.
//

import SwiftUI

struct MainTabView: View {
    
    let user: User
    
    @EnvironmentObject var viewModel: AuthViewModel

    
    var body: some View {
        NavigationView {
            TabView {
                FeedView().tabItem {
                    Image(systemName: "house")
                }
                
                SearchView().tabItem {
                    Image(systemName: "magnifyingglass")
                }
                
                UploadPostView().tabItem {
                    Image(systemName: "plus.square")
                }
                
                NotificationsView().tabItem {
                    Image(systemName: "heart")
                }
                
                ProfileView(user: user).tabItem {
                    Image(systemName: "person")
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: logoutButton)
            .accentColor(.black)
        }
    }
    
    var logoutButton: some View {
        
        Button {
            viewModel.signOut()
        } label: {
            Text("Logout").foregroundColor(.black)
        }
//        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//        })
    }
    
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
