import Foundation

struct MyProject: Codable, Identifiable {
    let id: Int
    let authorUser: AuthorUser
    let image: String
    let name: String
    let description: String
    let categories: [MyCategory]
    let userCount: Int
}

struct AuthorUser: Codable {
    let id: Int
    let image: String
    let username: String
    let email: String
    let role: String
}

struct MyCategory: Codable {
    let id: Int
    let name: String
    let color: String
}


class MyProjectAPIManager {
    static let shared = MyProjectAPIManager()
    
    private let baseURL = URL(string: "http://localhost:8080/api")!
    private let session = URLSession.shared
    
    func getMyProjects(completion: @escaping ([MyProject]?, Error?) -> Void) {
        let endpointURL = baseURL.appendingPathComponent("Users/my-projects")
        
        var request = URLRequest(url: endpointURL)
        request.addValue("Bearer \(UserDefaults.standard.string(forKey: "accessToken") ?? "")", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let projects = try decoder.decode([MyProject].self, from: data)
                completion(projects, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}

class MyProjectViewModel: ObservableObject {
    @Published var projects: [MyProject] = []
    
    func fetchMyProjects() {
        MyProjectAPIManager.shared.getMyProjects { projects, error in
            DispatchQueue.main.async {
                if let projects = projects {
                    self.projects = projects
                    print("projectek: \(projects)")
                }
            }
        }
    }
}

