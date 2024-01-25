//
//  Button.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 10..
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var buttonColor: Color
    var textColor: Color
    var function: () -> Void
    
    var body: some View {
        Button(action: function){
            ZStack{
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: .infinity, height: 52)
                    .background(buttonColor)
                    .cornerRadius(10)
                    .padding(.horizontal)
                Text(text)
                    .foregroundColor(textColor)
                    .font(
                    Font.custom("Montserrat", size: 18)
                    .weight(.bold)
                    )
            }
            
        }
    }
    init(text: String, buttonColor: Color, textColor: Color, function: @escaping () -> Void) {
        self.text = text
        self.buttonColor = buttonColor
        self.textColor = textColor
        self.function = function
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "", buttonColor: .black, textColor: .green, function: {})
    }
}
