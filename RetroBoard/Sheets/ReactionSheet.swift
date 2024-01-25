//
//  ReactionSheet.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import SwiftUI

struct ReactionSheet: View {
    @EnvironmentObject var reactionViewModel: ReactionViewModel
    @State private var entryId: String = ""
    @State private var reactionType: String = "Like"
    
    @State private var createdReaction: Reaction?
    
    var body: some View {
        VStack {
            TextField("Entry ID", text: $entryId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker("Reaction Type", selection: $reactionType) {
                Text("Like").tag("Like")
                Text("Dislike").tag("Dislike")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button("Send Reaction") {
                if let entryIdInt = Int(entryId) {
                    reactionViewModel.createReaction(entryId: entryIdInt, reactionType: reactionType) { result in
                        switch result {
                        case .success(let reaction):
                            createdReaction = reaction
                        case .failure(let error):
                            print("Error sending reaction: \(error)")
                        }
                    }
                }
            }
            
            if let reaction = createdReaction {
                Text("Created Reaction:")
                Text("ID: \(reaction.id ?? 0)") 
                
                if let user = reaction.user {
                    Text("User: \(user.username ?? "Unknown User")")
                } else {
                    Text("User: Unknown User")
                }
                
                if let entry = reaction.entry {
                    Text("Entry ID: \(entry.id ?? 0)")
                } else {
                    Text("Entry ID: Unknown Entry")
                }
                
                Text("Reaction Type: \(reaction.reactionType ?? "Unknown Reaction Type")")
            }

        }
        .padding()
    }
}


struct ReactionSheet_Previews: PreviewProvider {
    static var previews: some View {
        ReactionSheet()
            .environmentObject(ReactionViewModel())
    }
}
