//
//  Toolbar.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 13..
//

import SwiftUI

struct CustomToolbar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{

        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Mégse") {
                    dismiss()
                }
                .font(.title2)
                .foregroundColor(.white)
            }
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button("OK") {
                    dismiss()
                }
                .font(.title2)
                .foregroundColor(.white)
            }
        }
    }
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolbar()
    }
}
