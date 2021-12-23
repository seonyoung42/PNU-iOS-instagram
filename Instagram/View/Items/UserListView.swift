//
//  UserListView.swift
//  Instagram
//
//  Created by Sangkon Han on 2021/10/25.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel : SearchViewModel
    // searchText 앞에 ObservedObject? State? published? binding? environmentObject?
    // state => 내부 상태를 관리하는데 사용 => x
    // environmentObject => 전역 => x
    // published => 외부에서 내부의 값을 참조할 때 사용 => x
    // observedObject => 해당 객체가 변경되었는지 내(UserListView)가 알아야 할 때 사용 => x
    // binding => 외부 데이터를 전달 받아야 할 경우 => o
    @Binding var searchText: String
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach (users) { user in
                    NavigationLink(destination: ProfileView(user: user), label: {
                        UserCell(user: user).padding(.leading)
                    
                    })                    
                }
            }
        }
    }
}
