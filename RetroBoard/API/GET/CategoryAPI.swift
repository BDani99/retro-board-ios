//
//  CategoryAPI.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation

struct Category: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let color: String
}

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []

    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        guard let request = NetworkManager.shared.createRequest(.get, path: "Categories") else { return }

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decodedCategories = try JSONDecoder().decode([Category].self, from: data)
                DispatchQueue.main.async {
                    self?.categories = decodedCategories
                    print("Successfully fetched categories")
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }
        task.resume()
    }
}
