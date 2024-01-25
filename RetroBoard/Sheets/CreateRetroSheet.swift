//
//  CreateRetroSheet.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import SwiftUI

struct CreateRetroSheet: View {
    @EnvironmentObject var retrospectivesViewModel: PostRetroViewModel
    @State private var retrospectiveName: String = ""
    @State private var projectId: Int = 1
    @State private var statsNeeded: Bool = true
    @State private var retrospectiveId: Int? = nil
    
    let selectedProject: Int
    
    var body: some View {
        VStack {
            TextField("Retrospective Name", text: $retrospectiveName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Project ID", value: $projectId, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Toggle("Stats Needed", isOn: $statsNeeded)
                .padding()
            
            Button("Create Retrospective") {
                retrospectivesViewModel.createRetrospective(name: retrospectiveName, projectId: projectId, statsNeeded: statsNeeded) { result in
                    switch result {
                    case .success(let retrospective):
                        retrospectiveId = retrospective.id
                        print("Retrospective created: \(retrospective)")
                    case .failure(let error):
                        print("Error creating retrospective: \(error)")
                    }
                }
            }
            
            if let id = retrospectiveId {
                Text("Created Retrospective ID: \(id)")
            }
        }
        .onAppear {
            projectId = selectedProject
        }
        .padding()
    }
        
}

//
//struct CCreateRetroSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateRetroSheet()
//            .environmentObject(PostRetroViewModel())
//    }
//}
