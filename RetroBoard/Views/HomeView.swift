//
//  HomeView.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 11..
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var loginVM : LoginViewModel
    @EnvironmentObject var postVM: PostViewModel
    @EnvironmentObject var projectVM: ProjectViewModel
    
    @State private var isNewProject = false
    @State private var isAllProject = false
    @State private var isSearching = false
    
    @State private var isList = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if isList {
                    AllProjectList()
                } else {
                    AllProjectSheet()
                }
                Divider()
            }
            .navigationTitle("Projektek")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    if postVM.currentUser.role == "PM" {
                        Button {
                            isNewProject.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        .foregroundColor(.black)
                        .bold()
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    Button {
                        isList.toggle()
                    } label: {
                        Image(systemName: !isList ? "list.bullet" : "square.grid.2x2")
                    }
                    .foregroundColor(.black)
                    .bold()
                }
            }
            .refreshable {
                projectVM.fetchProjects()
            }
        }
        
        .onAppear{
            postVM.fetchData()
            projectVM.fetchProjects()
            
        }
        .sheet(isPresented: $isNewProject) {
            AddNewProject()
        }
        .sheet(isPresented: $isAllProject) {
            AllProjectSheet()
        }
        .sheet(isPresented: $isSearching) {
            GetProjectsView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(LoginViewModel())
            .environmentObject(PostViewModel())
    }
}
