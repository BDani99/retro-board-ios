//
//  GetProjectRetro.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 23..
//

import Foundation
import Combine

struct ProjectRetro: Codable, Identifiable {
    let id: Int
    let name: String
    let createdAt: String
    let statsNeeded: Bool
    let isActive: Bool
    let entryAmount: ProjectEntryAmount
//    let pieChartStats: PieChartStats?
//    let lineChartStats: LineChartStats?
}

struct ProjectEntryAmount: Codable {
    let todoColumn: Int
    let wentWellColumn: Int
    let needsFixColumn: Int
    let total: Int
}

class ProjectRetroViewModel: ObservableObject {
    @Published var retrospectives: [ProjectRetro] = []
    
    private let baseURL = URL(string: "http://localhost:8080/api/")!
   
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchRetrospectives(projectID: Int) {
        let url = baseURL.appendingPathComponent("Projects/\(projectID)/retrospectives")
        var request = URLRequest(url: url)
        request.addValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [ProjectRetro].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Fetching retrospectives failed with error: \(error)")
                }
            }, receiveValue: { [weak self] retrospectives in
                self?.retrospectives = retrospectives
                print("A retrok: \(retrospectives)")
            })
            .store(in: &cancellables)
    }
}
