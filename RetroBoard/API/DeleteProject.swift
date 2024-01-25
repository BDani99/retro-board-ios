//
//  DeleteProject.swift
//  RetroBoard
//
//  Created by user on 2023. 08. 14..
//

import Foundation
import Combine

class ProjectDeleteViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
    func deleteProject(projectID: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let request = NetworkManager.shared.createRequest(.delete, path: "Projects?id=\(projectID)") else {
            completion(.failure(NetworkError.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 204 {
                    completion(.success(()))
                } else {
                    completion(.failure(NetworkError.badStatus))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }
}
