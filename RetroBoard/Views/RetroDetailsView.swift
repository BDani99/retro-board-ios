import SwiftUI

struct RetroDetailsView: View {
    @EnvironmentObject var retroVM: RetrospectiveViewModel
    @EnvironmentObject var postVM: PostViewModel
    
    @State private var isNewProject = false
    @State private var createRetro = false
    @State private var isList = false
    @State private var createEntry = false
    
    let retroId: Int
 
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(retroVM.entries, id: \.id) { entry in
                                Button {
                                    
                                } label: {
                                    NavigationLink(destination: ProfileView()) {
                                        ZStack {
                                            VStack(alignment: .leading) {
                                                Text(entry.entryContent)
                                                    .font(.headline)
                                                
                                                if postVM.currentUser.role == "PM" {
                                                    Button("Retro stat") {
                                                        
                                                    }
                                                }
                                            }
                                            .foregroundColor(.white)
                                            .padding(.vertical)
                                            .frame(maxWidth: .infinity, maxHeight: 200)
                                            .background(Color.black.opacity(0.7))
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.gray)
                                            )
                                        }
                                        .padding()
                                    }
                                }
                            }
                            
                        }
                        .onAppear {
                            retroVM.fetchEntries(retrospectiveID: retroId)
                        }
                    }
                }
            }
        }
        .navigationTitle("Entryk")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                if postVM.currentUser.role == "PM" {
                    Button {
                        createEntry.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(.black)
                    .bold()
                }
            }
            
        }
        .sheet(isPresented: $createEntry) {
            CreateEntrySheet(selectedRetro: retroId)
        }
    }
}
