
import Foundation



class PatchingRetro {
    func setRetro(isActive: Bool, retroID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        struct SetRetro: Codable {
            let isActive: Bool
        }
        let settingRetro = SetRetro(isActive: !isActive)
        
        guard var request = NetworkManager.shared.createRequest(.patch, path: "Retrospectives/\(retroID)") else { completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(settingRetro) else {
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
                
                if 200..<300 ~= httpResponse.statusCode {
                    completion(.success(true))
                } else {
                    completion(.failure(NSError(domain: "Retro patching failed", code: httpResponse.statusCode, userInfo: nil)))
                }
            }
        }
        task.resume()

    }
}
