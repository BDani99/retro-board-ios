
import Foundation

struct TokenResponse: Decodable {
    let accessToken: String
}

class LoginManager {
    func loginUser(email: String, password: String ,completion: @escaping (Result<String, Error>) -> Void) {
        struct LoginData: Codable {
            let email: String
            let password: String
        }
        
        let loginData = LoginData(email: email, password: password)

        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(loginData) else {
            completion(.failure(NSError(domain: "Failed to encode data", code: 0, userInfo: nil)))
            return
        }
        
        guard var request = NetworkManager.shared.createRequest(.post, path: "Auth/") else {
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
                do {
                    let decoder = JSONDecoder()
                    let tokenResponse = try decoder.decode(TokenResponse.self, from: data)
                    let accessToken = tokenResponse.accessToken
                    NetworkManager.shared.accessToken = accessToken
                    completion(.success(accessToken))
                    print("accessToken: \(accessToken)")
                } catch {
                    print("Hiba történt a JWT token kinyerése közben: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

class LoginViewModel: ObservableObject {
    
    @Published var email: String = "teszt2@example.com"
    @Published var password: String = "Password2_"
    @Published var accessToken: String = ""
    @Published var isAuthenticated: Bool = false
    
    
    func login() {
        
        let defaults = UserDefaults.standard
        
        LoginManager().loginUser(email: email, password: password) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "accessToken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    print("Successfully logged in. isAuthenticated: \(self.isAuthenticated)")
                }
            case .failure(let error):
                print(error.localizedDescription)
                print("Login Error: \(error.localizedDescription)")
            }
        }
    }
    
    func signout() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "accessToken")
        isAuthenticated = false
        NetworkManager.shared.accessToken = ""
    }
    
}
