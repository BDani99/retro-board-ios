//
//  MultiPicker.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 11..
//

import SwiftUI

struct MultiSelectionView: View {
    var options: [User]
    @Binding var selected: [Int]
    
    var body: some View {
        List {
            ForEach(options, id: \.self) { user in
                MultipleSelectionRow(
                    isSelected: selected.contains(user.id),
                    label: user.username
                ) {
                    if selected.contains(user.id) {
                        selected.removeAll { $0 == user.id }
                    } else {
                        selected.append(user.id)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scrollContentBackground(.hidden)
        .padding(.horizontal)
    }
}

struct MultiselectionForCategory: View {
    var categoryOption: [Category]
    @Binding var selected: [Int]
    
    var body: some View {
        List {
            ForEach(categoryOption, id: \.self) { category in
                MultipleSelectionRow(
                    isSelected: selected.contains(category.id),
                    label: category.name
                ) {
                    if selected.contains(category.id) {
                        selected.removeAll { $0 == category.id }
                    } else {
                        selected.append(category.id)
                    }
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
        .scrollContentBackground(.hidden)
        .padding(.horizontal)
    }
}

struct MultipleSelectionRow: View {
    let isSelected: Bool
    let label: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            action()
        }
    }
}
