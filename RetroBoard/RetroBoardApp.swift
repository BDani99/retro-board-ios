//
//  RetroBoardApp.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 08..
//

import SwiftUI

@main
struct RetroBoardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoginViewModel())
                .environmentObject(PostViewModel())
                .environmentObject(CategoryViewModel())
                .environmentObject(ProjectViewModel())
                .environmentObject(ProjectIDViewModel())
                .environmentObject(ProjectDeleteViewModel())
                .environmentObject(UserListViewModel())
                .environmentObject(UserIDViewModel())
                .environmentObject(RetrospectiveViewModel())
                .environmentObject(PostRetroViewModel())
                .environmentObject(EntryViewModel())
                .environmentObject(EntryCreationViewModel())
                .environmentObject(ReactionViewModel())
                .environmentObject(MyProjectViewModel())
                .environmentObject(ProjectRetroViewModel())
        }
    }
}
