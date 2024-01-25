//
//  AllProjectSheet.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import SwiftUI

struct AllProjectSheet: View {
    @EnvironmentObject var myProjectVM: MyProjectViewModel
    @EnvironmentObject var postVM: PostViewModel
    @EnvironmentObject var retroVM: RetrospectiveViewModel

    
    @State private var isPatchingProject = false
    @State private var chosenProjectId : Int = 10
    @State private var chosenProjectImage : String = ""
    @State private var chosenProjectDescription : String = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView (showsIndicators: false){
                    LazyVGrid(columns: columns) {
                        ForEach(myProjectVM.projects) { project in
                            Button {
                                
                            } label: {
                                NavigationLink(destination: ProjectDetailsView(chosenProjectId: project.id)) {
                                    VStack() {
                                        HStack{
                                            Spacer()
                                            Text(project.name)
                                                .font(.headline)
                                            if postVM.currentUser.role == "PM" {
                                                Spacer()
                                                Button() {
                                                    chosenProjectId = project.id
                                                    chosenProjectImage = project.image
                                                    chosenProjectDescription = project.description
                                                    isPatchingProject.toggle()
                                                    print("\(chosenProjectId)")
                                                } label: {
                                                    Image(systemName: "ellipsis")
                                                        .foregroundColor(.white)
                                                        .font(.title3)
                                                        .bold()
                                                }
                                            }
                                            Spacer()
                                        }
                                        if project.image != "" {
                                            Image(project.image)
                                        } else {
                                            Image(systemName: "newspaper.fill")
                                                .padding(2)
                                        }
                                        Text(project.description)
                                            .font(.subheadline)
                                            .padding()
                                        Text("PM User: \(project.authorUser.username)")
                                            .font(.subheadline)
                                    }
                                    .foregroundColor(.white)
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .background(.black.opacity(0.7))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.gray)
                                    )
                                }
                                .onAppear {
                                    retroVM.fetchEntries(retrospectiveID: project.id)
                                }
                                    
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal)
                            .padding(.vertical)
                        }
                    }
                }
            }
            .onAppear{
                myProjectVM.fetchMyProjects()
            }
            .sheet(isPresented: $isPatchingProject) {
                ProjectPatching(chosenProjectId: chosenProjectId, chosenProjectImage: chosenProjectImage, chosenProjectDescription: chosenProjectDescription)
            }
        }
    }
}

struct AllProjectSheet_Previews: PreviewProvider {
    static var previews: some View {
        AllProjectSheet()
            .environmentObject(PostViewModel())
            .environmentObject(RetrospectiveViewModel())
        
    }
}
