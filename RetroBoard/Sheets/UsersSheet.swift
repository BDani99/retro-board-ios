//
//  UsersSheet.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 13..
//

import SwiftUI

struct UsersSheet: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userListVM: UserListViewModel
    
    @Binding var selectedUsers : [Int]
    
    var body: some View {
        NavigationView {
            ZStack{
                Rectangle().modifier(CustomBackground())
                
                VStack {
                    MultiSelectionView(options: userListVM.users,
                                       selected: $selectedUsers)
                    .padding()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Mégse") {
                        selectedUsers = []
                        dismiss()
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("OK") {
                        dismiss()
                    }
                    .font(.title2)
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear{
            userListVM.fetchUsers()
        }
        .presentationDetents([.height(300)])
    }
}

struct UsersSheet_Previews: PreviewProvider {
    static var previews: some View {
        UsersSheet(selectedUsers: .constant([]))
    }
}
