//
//  LoginView.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 10..
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginVM : LoginViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16){
                Spacer()
                Image(systemName: "r.square.on.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom)
                CustomTextField(text: "Felhasználónév", value: $loginVM.email, image: "person.circle.fill", eye: false)
                CustomTextField(text: "Jelszó", value: $loginVM.password, image: "lock.circle.fill", eye: true)
                CustomButton(text: "Bejelentkezés", buttonColor: .black.opacity(0.7), textColor: .white, function: loginVM.login)
                    .keyboardShortcut("\r", modifiers: [])
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegisterView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Nincsen felhasználó fiókod?")
                        
                        Text("Regisztrálj")
                            .bold()
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
