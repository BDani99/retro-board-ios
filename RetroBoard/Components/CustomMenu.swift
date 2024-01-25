//
//  CustomMenu.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 17..
//

import SwiftUI

struct CustomMenu: View {
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var userListVM: UserListViewModel
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedCategories: [Int]
    @Binding var selectedUsers: [Int]
    
    @State private var showCategoryMenu = false
    @State private var showUsersMenu = false
    
    var body: some View {
        HStack {
            Button("Kategóriák") {
                showCategoryMenu.toggle()
            }
            .popover(isPresented: $showCategoryMenu) {
                List(categoryVM.categories, id: \.self) { category in
                    Button(action: {
                        if selectedCategories.contains(category.id) {
                            selectedCategories.removeAll { $0 == category.id }
                        } else {
                            selectedCategories.append(category.id)
                        }
                    }) {
                        HStack {
                            Text(category.name)
                            Spacer()
                            if selectedCategories.contains(category.id) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .foregroundColor(.black).bold()
            Spacer()
            
            Button("Felhasználók") {
                showUsersMenu.toggle()
            }
            .popover(isPresented: $showUsersMenu) {
                List(userListVM.users, id: \.self) { user in
                    Button(action: {
                        if selectedUsers.contains(user.id) {
                            selectedUsers.removeAll { $0 == user.id }
                        } else {
                            selectedUsers.append(user.id)
                        }
                    }) {
                        HStack {
                            Text("\(user.username)")
                            Spacer()
                            if selectedUsers.contains(user.id) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .foregroundColor(.black).bold()
        }
        .onAppear{
            userListVM.fetchUsers()
            categoryVM.fetchCategories()
        }
    }
}

struct CustomMenu_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenu(selectedCategories: .constant([]), selectedUsers: .constant([]))
    }
}
