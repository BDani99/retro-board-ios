//
//  EntrySheet.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import SwiftUI

struct EntrySheet: View {
    @EnvironmentObject var viewModel: EntryViewModel
    @State private var categories: [Entries] = []
    @State private var entryId: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Entry ID", text: $entryId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Fetch Categories") {
                if let id = Int(entryId) {
                    viewModel.getCategories(for: id) { result in
                        switch result {
                        case .success(let categories):
                            self.categories = categories
                        case .failure(let error):
                            print("Error fetching categories: \(error)")
                        }
                    }
                }
            }
            
            List(categories, id: \.id) { category in
                Text("Name: \(category.name)")
                Text("ID: \(category.id)")
            }
        }
    }
}

struct EntrySheet_Previews: PreviewProvider {
    static var previews: some View {
        EntrySheet()
            .environmentObject(EntryViewModel())
    }
}
