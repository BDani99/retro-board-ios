//
//  RegisterView.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 10..
//

import SwiftUI

struct RegisterView: View {
    @State private var userName = ""
    @State private var email = ""
    @State private var password1 = ""
    @State private var password2 = ""
    @State private var alertMessage = ""
    @State private var alertButtonMessage = ""
    @State private var profilePicture = ""
    
    @State private var showingAlert = false
    @State private var validregistration = false
    
    @State private var registration = RegistrationManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                Image(systemName: "r.square.on.square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .padding(.bottom)
                
                CustomTextField(text: "Felhasználónév",
                                value: $userName,
                                image: "person.circle.fill",
                                eye: false)
                CustomTextField(text: "Email",
                                value: $email,
                                image: "envelope.circle.fill",
                                eye: false)
                CustomTextField(text: "Jelszó",
                                value: $password1,
                                image: "lock.circle.fill",
                                eye: true)
                CustomTextField(text: "Jelszó",
                                value: $password2,
                                image: "lock.circle.fill",
                                eye: true)
                
                CustomButton(text: "Regisztráció",
                             buttonColor: .black.opacity(0.7),
                             textColor: .white,
                             function: Register)
                .padding(.top)
                
                Spacer()
                
                Divider()
                
                
                NavigationLink {
                    LoginView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Van már felhasználód?")
                        
                        Text("Jelentkezz be")
                            .bold()
                    }
                    .foregroundColor(.black)
                    .font(.footnote)
                }
                .padding(.vertical, 16)
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Fontos információ"), message: Text(alertMessage), dismissButton: .default(Text("\(alertButtonMessage)")) )
        }
    }
    func isPasswordValid() -> Bool {
        let capitalLetterPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*")
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*")
        
        return capitalLetterPredicate.evaluate(with: password1) &&
        numberPredicate.evaluate(with: password1)
    }
    
    func Register() {
        if password1 == password2 && email.contains("@") && isPasswordValid() {
            registration.registerUser(userName: userName, email: email, password: password1, confirmPassword: password2, image: profilePicture) {result in
                switch result{
                case .success(let data):
                    print("Registration successful. Response data: \(String(data: data, encoding: .utf8) ?? "")")
                    showingAlert = true
                    alertMessage = "Sikerese regisztráció."
                    alertButtonMessage = "OK"
                    validregistration = true
                    
                case .failure(let error):
                    print("Registration failed. Error: \(error.localizedDescription)")
                    showingAlert = true
                    alertMessage = "Sikertelen regisztráció, Próbáld újra."
                    alertButtonMessage = "OK"
                }
            }
        } else if isPasswordValid() != true {
            showingAlert = true
            alertMessage = "Nem megfelelő a jelszó formátuma."
            alertButtonMessage = "Próbáld Újra"
        } else if password1 != password2 {
            showingAlert = true
            alertMessage = "Nem egyeznek a jelszavak."
            alertButtonMessage = "Próbáld Újra"
        } else{
            showingAlert = true
            alertMessage = "Nem megfelelő az emailcím formátuma."
            alertButtonMessage = "Próbáld Újra"
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
