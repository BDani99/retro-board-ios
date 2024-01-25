//
//  AddNewProject.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 11..
//

import SwiftUI

struct AddNewProject: View {
    @EnvironmentObject var loginVM : LoginViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedCategories: [Int] = []
    @State private var selectedUsers: [Int] = []
    
    @State private var newProjectPost = PostingProject()
    
    @State private var projectImage: String = ""
    @State private var projectName: String = ""
    @State private var projectDescription: String = ""
    
    var body: some View {
        
        NavigationStack {
            
            VStack() {
                CustomTextField(text: "Kép",
                                value: $projectImage,
                                image: "photo.on.rectangle.angled",
                                eye: false)
                CustomTextField(text: "Projekt neve",
                                value: $projectName,
                                image: "square.and.pencil",
                                eye: false)
                CustomTextField(text: "Leírás",
                                value: $projectDescription,
                                image: "scroll",
                                eye: false)
                
                VStack(alignment: .leading, spacing: 10){
                    HStack {
                        Text("Választott kategóriák: ")
                        ForEach(selectedCategories, id: \.self){
                            Text("\($0)")
                        }
                    }
                    HStack {
                        Text("Választott felhasználók: ")
                        ForEach(selectedUsers, id: \.self){user in
                            Text("\(user)")
                        }
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .foregroundColor(.black)
                CustomMenu(selectedCategories: $selectedCategories,
                           selectedUsers: $selectedUsers)
                
                CustomButton(text: "Létrehozás", buttonColor: .black.opacity(0.7), textColor: .white, function: newProject)
                
            }.padding(.horizontal)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Mégse") {
                    dismiss()
                }
                .font(.title2)
                .foregroundColor(.black.opacity(0.7))
            }
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("OK") {
                    dismiss()
                }
                .font(.title2)
                .foregroundColor(.black.opacity(0.7))
            }
        }
    }
    func newProject() {
        newProjectPost.postProject(image: projectImage,
                                   name: projectName,
                                   description: projectDescription,
                                   categoryIds: selectedCategories,
                                   userIds: selectedUsers) { result in
            switch result {
            case .success(let data):
                print("Project posting successful. Response data: \(String(data: data, encoding: .utf8) ?? "")")
                dismiss()
                
            case .failure(let error):
                print("Project posting failed. Error: \(error.localizedDescription)")
            }
        }
    }
}

struct AddNewProject_Previews: PreviewProvider {
    static var previews: some View {
        AddNewProject()
            .environmentObject(LoginViewModel())
    }
}

