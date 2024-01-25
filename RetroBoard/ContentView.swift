//
//  ContentView.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 08..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack {
            if !loginVM.isAuthenticated {
                LoginView()
            } else {
                TabBarView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginViewModel())
    }
}
