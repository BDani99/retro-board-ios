//
//  GetProjectsView.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import SwiftUI

struct GetProjectsView: View {
    @EnvironmentObject var projectIDVM: ProjectIDViewModel
    @EnvironmentObject var projectDelete: ProjectDeleteViewModel
    @State private var projectIDInput: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Projekt azonosító", text: $projectIDInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button("keresés") {
                            if let projectID = Int(projectIDInput) {
                                projectIDVM.fetchProjectDetails(projectID: projectID)
                            }
                        }
                        
                        Spacer()
                        
                        Button("Törlés") {
                            if let projectID = Int(projectIDInput) {
                                projectDelete.deleteProject(projectID: projectID) { result in
                                    switch result {
                                    case .success:
                                        print("Project deleted successfully.")
                                    case .failure(let error):
                                        print("Error deleting project: \(error)")
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                        
                    }
                    .padding(.bottom)
                    
                    if let project = projectIDVM.project {
                        VStack {
                            Text("Name: \(project.name)")
                                .font(.headline)
                            Text("Description: \(project.description)")
                                .font(.subheadline)
                            Text("PM User: \(project.pmUser.username)")
                                .font(.subheadline)
                        }
                        .navigationBarTitle("Projekt adatok")
                    } else {
                        Text("Project details will be shown here.")
                    }
                }
            }
        }
    }
}

struct GetProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        GetProjectsView()
            .environmentObject(ProjectIDViewModel())
    }
}
