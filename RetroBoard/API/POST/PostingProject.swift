//
//  PostingProject.swift
//  RetroBoard
//
//  Created by Attrecto on 2023. 08. 11..
//

import Foundation

class PostingProject {
    func postProject(image: String?, name: String, description: String?, categoryIds: [Int], userIds: [Int], completion: @escaping (Result<Data, Error>) -> Void) {
        struct ProjectData: Codable {
            let image: String?
            let name: String
            let description: String?
            let categoryIds: [Int]
            let userIds: [Int]
        }
        
        let projectData = ProjectData(image: image, name: name, description: description, categoryIds: categoryIds, userIds: userIds)

        guard var request = NetworkManager.shared.createRequest(.post, path: "Projects/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(projectData) else {
            completion(.failure(NSError(domain: "Failed to encode data", code: 0, userInfo: nil)))
            return
        }

        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }
}
