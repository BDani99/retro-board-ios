
import Foundation

class RegistrationManager {
    func registerUser(userName: String, email: String, password: String, confirmPassword: String, image: String, completion: @escaping (Result<Data, Error>) -> Void) {
        struct RegistrationData: Codable {
            let userName: String
            let email: String
            let password: String
            let confirmPassword: String
            let image: String
        }
        
        let registrationData = RegistrationData(userName: userName, email: email, password: password, confirmPassword: confirmPassword, image: image)

        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(registrationData) else {
            completion(.failure(NSError(domain: "Failed to encode data", code: 0, userInfo: nil)))
            return
        }
        
        guard var request = NetworkManager.shared.createRequest(.post, path: "Users/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
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

struct RegistrationData: Codable {
    var userName: String
    var email: String
    var password: String
    var confirmPassword: String
    var image: String
}
