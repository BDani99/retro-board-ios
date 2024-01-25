//
//  GetRetro.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation
import Combine

struct RetrospectiveEntry: Codable, Identifiable {
    let id: Int
    let entryContent: String
    let categories: [RetroCategory]
    let retrospective: Retrospective
    let assignee: RetroUser
    let author: RetroUser
    let columnType: String
    let reactionAmount: ReactionAmount
    let currentUserReaction: String?
}

struct RetroCategory: Codable {
    let id: Int
    let name: String
    let color: String
}

struct Retrospective: Codable {
    let id: Int
    let name: String
    let createdAt: String
    let statsNeeded: Bool
    let isActive: Bool
    let entryAmount: EntryAmount
}

struct EntryAmount: Codable {
    let todoColumn: Int
    let wentWellColumn: Int
    let needsFixColumn: Int
    let total: Int
}

struct ReactionAmount: Codable {
    let likeAmount: Int
    let dislikeAmount: Int
}

struct RetroUser: Codable {
    let id: Int
    let image: String
    let username: String
    let email: String
    let role: String
}


class RetrospectiveViewModel: ObservableObject {
    @Published var entries: [RetrospectiveEntry] = []
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchEntries(retrospectiveID: Int) {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Retrospectives/\(retrospectiveID)/entries") else { return }

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [RetrospectiveEntry].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] entries in
                self?.entries = entries
            }
            .store(in: &cancellables)
    }
}

