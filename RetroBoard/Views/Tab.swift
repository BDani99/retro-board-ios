
import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab){
            
            HomeView()
                .tabItem{
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 0
                }
                .tag(0)
            TestView()
                .tabItem{
                    Image(systemName: selectedTab == 1 ? "newspaper.fill" : "newspaper")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 1
                }
                .tag(1)
            UsersView()
                .tabItem{
                    Image(systemName: selectedTab == 2 ? "person.2.fill" : "person.2")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 2
                }
                .tag(2)
            ProfileView()
                .tabItem{
                    Image(systemName: selectedTab == 3 ? "gearshape.fill" : "gearshape")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear {
                    selectedTab = 3
                }
                .tag(3)
        }.tint(.black)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(LoginViewModel())
            .environmentObject(PostViewModel())
            .environmentObject(CategoryViewModel())
            .environmentObject(ProjectViewModel())
            .environmentObject(ProjectIDViewModel())
            .environmentObject(ProjectDeleteViewModel())
    }
}

