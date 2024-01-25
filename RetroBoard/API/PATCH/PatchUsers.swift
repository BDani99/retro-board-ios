
import Foundation

class PatchingUser {
    func patchUser(image: String, username: String, userID: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        struct PatchUser: Codable {
            let image: String
            let username: String
        }
        let patchingUser = PatchUser(image: image, username: username)
        
        guard var request = NetworkManager.shared.createRequest(.patch, path: "Retrospectives/\(userID)") else { completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(patchingUser) else {
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
                completion(.failure(NSError(domain: "No data received for user patching", code: 0, userInfo: nil)))
            }
        }
        task.resume()
    }
}

