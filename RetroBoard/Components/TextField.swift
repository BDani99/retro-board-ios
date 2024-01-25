//
//  TextField.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 10..
//

import SwiftUI

struct CustomTextField: View {
    var text: String
    @Binding var value: String
    var image: String
    var eye: Bool
    @State private var showPassword = false
    
    var body: some View {
        ZStack {
            HStack {
                Image(systemName: image).font(.title2).padding(.horizontal, 3)
                
                if eye {
                    if showPassword {
                        TextField(text, text: $value)
                            .foregroundColor(Color.gray.opacity(0.4))
                            .font(Font.custom("Montserrat", size: 14)
                            .weight(.light)
                            )
                    } else {
                        SecureField(text, text: $value).font(
                            Font.custom("Montserrat", size: 14)
                            .weight(.light)
                            )
                    }
                } else {
                    TextField(text, text: $value)
                        .font(.subheadline)
                }
                Spacer()
                if eye {
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill").foregroundColor(.black
                        )
                    }
                }
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)
            .autocapitalization(.none)

        }
    }
    init(text: String, value: Binding<String>, image: String, eye: Bool, showPassword: Bool = false) {
        self.text = text
        self._value = value
        self.image = image
        self.eye = eye
        self.showPassword = showPassword
    }
}

struct TextField_Previews: PreviewProvider {
    @State static var inputValue = "Initial Value"
    
    static var previews: some View {
        CustomTextField(text: "kecske", value: $inputValue, image: "pencil", eye: false)
    }
}
