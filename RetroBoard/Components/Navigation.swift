

import SwiftUI

struct CustomNavigation<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let content: Content
    var text: String
    var arrow: Bool
    
    init(arrow: Bool, text: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.text = text
        self.arrow = arrow
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont(name: "Arial", size: 30)!]
    }
    
    var body: some View {
        NavigationView {
            content
                .navigationBarItems(leading:Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        if arrow {
                            Image(systemName: "chevron.left")
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                        }
                    }
                })
                .navigationBarTitle(text, displayMode: .inline).font(.title2)
                .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}
