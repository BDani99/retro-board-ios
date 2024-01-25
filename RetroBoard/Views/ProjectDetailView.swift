//
//  ProjectDetailView.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 17..
//

import SwiftUI

struct ProjectDetailsView: View {
    @EnvironmentObject var retroVM: RetrospectiveViewModel
    @EnvironmentObject var myProjectVM: MyProjectViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    @EnvironmentObject var postVM: PostViewModel
    @EnvironmentObject var entryVM: EntryViewModel
    @EnvironmentObject var projectRetroVM: ProjectRetroViewModel
    
    @State private var isNewProject = false
    @State private var createRetro = false
    @State private var isList = false
    
    let chosenProjectId: Int
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
           NavigationStack {
               ZStack {
                   VStack {
                       ScrollView(showsIndicators: false) {
                           LazyVGrid(columns: columns) {
                               ForEach(projectRetroVM.retrospectives) { retrospective in
                                   NavigationLink(destination: RetroDetailsView(retroId: retrospective.id)) {
                                       ZStack {
                                           VStack(alignment: .leading) {
                                               Text(retrospective.name)
                                                   .font(.headline)
                                              
                                                  
                                               if postVM.currentUser.role == "PM" {
                                                   Button("Retro stat") {
                                                       
                                                   }
                                               }
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
                                       .padding()
                                   }
                               }
                           }
                           .onAppear {
                               let _ = print("ezaz: \(chosenProjectId)")
                               projectRetroVM.fetchRetrospectives(projectID: chosenProjectId)
                           }
                       }
                   }
               }
           }
           .navigationTitle("Retrospektívek")
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItemGroup(placement: .navigationBarLeading) {
                   if postVM.currentUser.role == "PM" {
                       Button {
                           createRetro.toggle()
                       } label: {
                           Image(systemName: "plus")
                       }
                       .foregroundColor(.black)
                       .bold()
                   }
               }
           }
           .sheet(isPresented: $createRetro) {
               CreateRetroSheet(selectedProject: chosenProjectId)
           }
       }
   }
