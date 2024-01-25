//
//  Users.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation
import Combine

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let image: String
    let username: String
    let email: String
    let role: String
}

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchUsers() {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Users") else { return }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}

class UserIDViewModel: ObservableObject {
    @Published var user: User?
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchUserDetail(userID: Int) {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Users/\(userID)") else { return }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)
    }
}
