//
//  CreateEntrySheet.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import SwiftUI

struct CreateEntrySheet: View {
    @EnvironmentObject var entryCreationViewModel: EntryCreationViewModel
    @State private var entryContent: String = ""
    @State private var categoryIds: String = ""
    @State private var retrospectiveId: Int = 0
    @State private var assigneeId: Int = 0
    @State private var columnType: String = ""
    @State private var createdEntry: Entry?
    
    let selectedRetro: Int
    
    var body: some View {
        VStack {
            TextField("Entry Content", text: $entryContent)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Category ID", text: $categoryIds)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Retrospective ID", value: $retrospectiveId, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Assignee ID", value: $assigneeId, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Column Type", text: $columnType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Create Entry") {
                let categoryIdsArray = categoryIds.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
                entryCreationViewModel.createEntry(entryContent: entryContent, categoryIds: categoryIdsArray, retrospectiveId: retrospectiveId, assigneeId: assigneeId, columnType: columnType) { result in
                    switch result {
                    case .success(let entry):
                        createdEntry = entry
                    case .failure(let error):
                        print("Error creating entry: \(error)")
                    }
                }
            }
            
            if let entry = createdEntry {
                Text("Created Entry:")
                Text("ID: \(entry.id)")
                Text("Content: \(entry.entryContent)")
                
            }
        }
        .onAppear {
            retrospectiveId = selectedRetro
        }
        .padding()
    }
    
}


struct CreateEntrySheet_Previews: PreviewProvider {
    static var previews: some View {
        CreateEntrySheet(selectedRetro: 1)
            .environmentObject(EntryCreationViewModel())
    }
}
