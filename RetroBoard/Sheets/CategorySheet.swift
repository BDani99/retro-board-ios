//
//  CategorySheet.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 13..
//

import SwiftUI

struct CategorySheet: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCategories: [Int]
    @EnvironmentObject var categoryVM: CategoryViewModel
    @EnvironmentObject var userListVM: UserListViewModel
    
    @State private var mockCategory = [ 1, 2, 3, 4, 5]
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().modifier(CustomBackground())
                
                VStack {
                    MultiselectionForCategory(categoryOption: categoryVM.categories, selected: $selectedCategories)
                    .padding()
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Mégse") {
                        selectedCategories = []
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
        .presentationDetents([.height(300)])
    }
}

struct CategorySheet_Previews: PreviewProvider {
    static var previews: some View {
        CategorySheet(selectedCategories: .constant([]))
    }
}
