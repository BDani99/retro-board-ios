

import SwiftUI

struct AllProjectList: View {
    @EnvironmentObject var projectVM: ProjectViewModel
    @EnvironmentObject var postVM: PostViewModel
    
    @State private var isPatchingProject = false
    @State private var chosenProjectId : Int = 10
    @State private var chosenProjectImage : String = ""
    @State private var chosenProjectDescription : String = ""
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(projectVM.projects) { project in
                    VStack() {
                        HStack{
                            Spacer()
                            Text(project.name)
                                .font(.headline)
                            if postVM.currentUser.role == "PM" {
                                Spacer()
                                Button(){
                                    isPatchingProject.toggle()
                                    chosenProjectId = project.id
                                    chosenProjectImage = project.image
                                    chosenProjectDescription = project.description
                                    print("\(project.categories)")
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.white)
                                        .font(.title3)
                                        .bold()
                                }
                            }
                            Spacer()
                        }
                        if project.image != "" {
                            Image(project.image)
                        } else {
                            Image(systemName: "newspaper.fill")
                                .padding(2)
                        }
                        Text(project.description)
                            .font(.subheadline)
                            .padding()
                        Text("PM User: \(project.pmUser.username)")
                            .font(.subheadline)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray)
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .sheet(isPresented: $isPatchingProject) {
            ProjectPatching(chosenProjectId: chosenProjectId, chosenProjectImage: chosenProjectImage, chosenProjectDescription: chosenProjectDescription)
        }
    }
}

struct AllProjectList_Previews: PreviewProvider {
    static var previews: some View {
        AllProjectList()
            .environmentObject(ProjectViewModel())
            .environmentObject(PostViewModel())
    }
}
