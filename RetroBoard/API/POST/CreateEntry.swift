//
//  CreateEntry.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 15..
//

import Foundation

struct Entry: Codable {
    let id: Int
    let entryContent: String
    let categories: [Category]
    let retrospective: Retrospective
    let assignee: User
    let author: User 
    let columnType: String
    let reactionAmount: Int?
    let currentUserReaction: String?
}

class EntryCreationViewModel: ObservableObject {
    func createEntry(entryContent: String, categoryIds: [Int], retrospectiveId: Int, assigneeId: Int, columnType: String, completion: @escaping (Result<Entry, Error>) -> Void) {
        guard var request = NetworkManager.shared.createRequest(.post, path: "Entries") else {
            completion(.failure(NetworkError.badUrl))
            return
        }

        let requestBody: [String: Any] = [
            "entryContent": entryContent,
            "categoryIds": categoryIds,
            "retrospectiveId": retrospectiveId,
            "assigneeId": assigneeId,
            "columnType": columnType
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let createdEntry = try decoder.decode(Entry.self, from: data)
                completion(.success(createdEntry))
            } catch let decodingError {
                print("JSON decoding error: \(decodingError)")
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
