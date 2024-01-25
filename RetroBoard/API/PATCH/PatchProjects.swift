
import Foundation



class PatchingProject {
    func patchProject(image: String?, description: String, hasRetroboard: Bool?,  categoryIds: [Int], userIds: [Int], projectID: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        struct PatchProjectData: Codable {
            let image: String?
            let description: String
            let hasRetroboard: Bool?
            let categoryIds: [Int]
            let userIds: [Int]
        }
        let patchProjectData = PatchProjectData(image: image, description: description, hasRetroboard: hasRetroboard, categoryIds: categoryIds, userIds: userIds)
        
        guard var request = NetworkManager.shared.createRequest(.patch, path: "Projects?id=\(projectID)") else { completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(patchProjectData) else {
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
                if httpResponse.statusCode == 404 {
                    completion(.failure(NSError(domain: "Resource not found", code: 404, userInfo: nil)))
                    return
                }
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
