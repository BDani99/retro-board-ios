//
//  ProfileView.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 11..
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var postVM: PostViewModel
    @EnvironmentObject var loginVM: LoginViewModel
    
    var body: some View {
        VStack {
            if let image = UIImage(named: postVM.currentUser.image) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top, 20)
            }
            
            Text("Üdvözlet \(postVM.currentUser.username)")
                .padding()
            Divider()
            Spacer()
            if postVM.currentUser.image == "" {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
            } else {
                Image(postVM.currentUser.image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
            }
            VStack(alignment: .leading) {
            Text("Username: \(postVM.currentUser.username)")
                .padding()
            
            Text("Email: \(postVM.currentUser.email)")
                .padding()
            
            Text("Role: \(postVM.currentUser.role)")
                .padding()
                
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray)
            )
            Spacer()
            CustomButton(text: "Kijelentkezés",
                         buttonColor: Color.black.opacity(0.7),
                         textColor: .white,
                         function: { loginVM.signout() } ).padding()
            Divider()
        }
        .onAppear {
            postVM.fetchData()
        }
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(PostViewModel())
    }
}
