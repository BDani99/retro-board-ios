//
//  Preview.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 18..
//

import SwiftUI

struct Preview: View {
    var body: some View {
        NavigationStack {
            VStack{
                Text("Üdv Felhasználó!")
                    .padding()
                    .font(.title)
                    .bold()
                Text("Kérjük, jelentkezzen be fiókjába vagy hozzon létre új fiókot a folytatáshoz.")
                    .padding(.bottom)
                VStack(spacing: 16) {
                    NavigationLink(destination: LoginView()) {
                        Text("Bejelentkezés")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Regisztráció")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                }
            }.padding(.horizontal)
        }
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
}
