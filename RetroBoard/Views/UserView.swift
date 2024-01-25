import SwiftUI

struct UserView: View {
    @EnvironmentObject var loginVM: LoginViewModel
    @State private var isList = false
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(isUserLoggedIn: $loginVM.isAuthenticated, isList: $isList)
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}
struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(LoginViewModel())
    }
}
