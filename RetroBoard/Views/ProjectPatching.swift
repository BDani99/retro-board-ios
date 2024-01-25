//
//  PatchProject.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 18..
//

import SwiftUI

struct ProjectPatching: View {
    @EnvironmentObject var loginVM : LoginViewModel
    @EnvironmentObject var projectVM : ProjectViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var patchPtoject = PatchingProject()
    //@Binding var chosenProjectId : Int
    let chosenProjectId : Int
    let chosenProjectImage : String
    let chosenProjectDescription : String

    @State private var newImage : String = ""
    @State private var newDescription : String = ""
    @State private var newCategoryIds : [Int] = []
    @State private var newUserIds : [Int] = []
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.gray.opacity(0.3)).ignoresSafeArea()
            VStack {
                Text("Project változtatása")
                
                VStack {
                    CustomTextField(text: "Új kép", value: $newImage, image: "photo.on.rectangle.angled", eye: false)
                    CustomTextField(text: "Új leírás", value: $newDescription, image: "doc.plaintext", eye: false)
                    HStack {
                        CustomMenu(selectedCategories: $newCategoryIds, selectedUsers: $newUserIds)
                    }
                    CustomButton(text: "Változtatás", buttonColor: .black.opacity(0.4), textColor: .white, function: PatchProject)
                }
            }
        }
        .onAppear{
            newImage = chosenProjectImage
            newDescription = chosenProjectDescription
        }
    }
    func PatchProject() {
        patchPtoject.patchProject(image: newImage, description: newDescription, hasRetroboard: true, categoryIds: newCategoryIds, userIds: newUserIds, projectID: chosenProjectId) { result in
            switch result {
            case.success(let data):
                print("Project patching successful. Response data: \(String(data: data, encoding: .utf8) ?? "")")
                dismiss()
            case.failure(let error):
                print("Project patching failed. Error: \(error.localizedDescription)")
            }
        }
    }
}

struct ProjectPatching_Previews: PreviewProvider {
    static var previews: some View {
        ProjectPatching(chosenProjectId: 1, chosenProjectImage: "", chosenProjectDescription: "")
    }
}
