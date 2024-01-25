//
//  SideBar.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import Foundation
import SwiftUI

import SwiftUI

struct HeaderView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var isList: Bool
    @EnvironmentObject var user: PostViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        HStack {
           
            Image("logo")
                .resizable()
                .frame(width: 150, height: 25)
        
            Spacer()
            Button {
                isList.toggle()
            } label: {
                Image(systemName: !isList ? "list.bullet" : "square.grid.2x2")
            }
            .foregroundColor(.black)
            .bold()
        }
        .padding()
        Divider()
    }
}
