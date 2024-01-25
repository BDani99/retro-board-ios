//
//  ProjectGetAPI.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation
import Combine

struct PMUser: Codable {
    let id: Int
    let image: String
    let username: String
    let email: String
    let role: String
}

struct Categories: Codable {
    let id: Int
    let name: String
    let color: String
}

struct Project: Codable, Identifiable {
    let id: Int
    let pmUser: PMUser
    let image: String
    let name: String
    let description: String
    let hasRetroboard: Bool
    let categories: [Category]
}

class ProjectViewModel: ObservableObject {
    @Published var projects: [Project] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchProjects()
    }
    
    func fetchProjects() {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Projects") else { return }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Project].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.projects, on: self)
            .store(in: &cancellables)
    }
}

class ProjectIDViewModel: ObservableObject {
    @Published var project: Project = Project(id: -1, pmUser: PMUser(id: -1, image: "", username: "", email: "", role: ""), image: "", name: "", description: "", hasRetroboard: false, categories: [])
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchProjectDetails(projectID: Int) {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Projects/\(projectID)") else { return }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Project.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] project in
                self?.project = project
            }
            .store(in: &cancellables)
        
        
    }
    
}
