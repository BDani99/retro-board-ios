//
//  UsersView.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var userListVM: UserListViewModel
    @EnvironmentObject var userDetailViewModel: UserIDViewModel
    @State private var userIDInput: String = ""
    
    var body: some View {
        VStack {
            List(categoryVM.categories) { category in
                VStack(alignment: .leading) {
                    Text(String(category.id))
                        .font(.headline)
                    Text(category.name)
                        .font(.subheadline)
                }
                
            }
            Spacer()
            
            List(userListVM.users, id: \.id) { user in
                VStack(alignment: .leading) {
                    Text("Username: \(user.username)")
                        .font(.headline)
                    Text("Email: \(user.email)")
                        .font(.subheadline)
                    Text("Role: \(user.role)")
                        .font(.subheadline)
                }
            }
            .navigationBarTitle("User List")
            .onAppear {
                userListVM.fetchUsers()
            }
            
            VStack {
                TextField("Enter User ID", text: $userIDInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Fetch User Details") {
                    if let userID = Int(userIDInput) {
                        userDetailViewModel.fetchUserDetail(userID: userID)
                    }
                }
                
                if let user = userDetailViewModel.user {
                    VStack(alignment: .leading) {
                        Text("Username: \(user.username)")
                            .font(.headline)
                        Text("Email: \(user.email)")
                            .font(.subheadline)
                        Text("Role: \(user.role)")
                            .font(.subheadline)
                    }
                } else {
                    Text("User details will be shown here.")
                }
            }
            .padding()
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
