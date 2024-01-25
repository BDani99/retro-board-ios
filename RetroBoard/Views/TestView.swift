//
//  ProjectView.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import SwiftUI

struct TestView: View {
    @State private var isRetro = false
    @State private var isRetroCreate = false
    @State private var isShowEntry = false
    @State private var createEntry = false
    @State private var reaction = false
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomButton(text:"Retro", buttonColor: .black.opacity(0.4), textColor: .white, function: {isRetro.toggle()})
                
                CustomButton(text:"Retro create", buttonColor: .black.opacity(0.4), textColor: .white, function: {isRetroCreate.toggle()})
                
                CustomButton(text:"Entry kategória", buttonColor: .black.opacity(0.4), textColor: .white, function: {isShowEntry.toggle()})
                
                CustomButton(text:"Entryk létrehozása", buttonColor: .black.opacity(0.4), textColor: .white, function: {createEntry.toggle()})
                
                CustomButton(text:"Reagálás", buttonColor: .black.opacity(0.4), textColor: .white, function: {reaction.toggle()})
                
                
            }
        }
        .sheet(isPresented: $isRetro) {
            RetroSheet()
        }
//        .sheet(isPresented: $isRetroCreate) {
//            CreateRetroSheet()
//        }
        .sheet(isPresented: $isShowEntry) {
            EntrySheet()
        }
//        .sheet(isPresented: $createEntry) {
//            CreateEntrySheet()
//        }
        .sheet(isPresented: $reaction) {
            ReactionSheet()
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
        
    }
}
