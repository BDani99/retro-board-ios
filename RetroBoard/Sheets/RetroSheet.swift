import SwiftUI

struct RetroSheet: View {
    @EnvironmentObject var retroVM: RetrospectiveViewModel
    @State private var retrospectiveIDInput: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter Retrospective ID", text: $retrospectiveIDInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Fetch Entries") {
                if let retrospectiveID = Int(retrospectiveIDInput) {
                    retroVM.fetchEntries(retrospectiveID: retrospectiveID)
                }
            }
            
            List(retroVM.entries, id: \.id) { entry in
                VStack(alignment: .leading) {
                    Text("Entry Content: \(entry.entryContent)")
                        .font(.headline)
                    Text("Author: \(entry.author.username)")
                        .font(.subheadline)
                    Text(entry.retrospective.name)
                    Text(entry.assignee.username)
                    Text(entry.columnType)
                
                }
            }
        }
        .padding()
    }
}

struct RetroSheet_Previews: PreviewProvider {
    static var previews: some View {
        RetroSheet()
            .environmentObject(RetrospectiveViewModel())
    }
}
