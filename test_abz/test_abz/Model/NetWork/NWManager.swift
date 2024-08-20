//
//  NWManager.swift
//  test_abz
//
//  Created by mac on 19.08.2024.
//

import Foundation
import Alamofire


// MARK: - NWManager

class NWManager {
    
    static let shared = NWManager()
    
    private let baseURL = "https://frontend-test-assignment-api.abz.agency/api/v1"
    
    private let tokenKey = "authToken"
    var authToken: String? {
        get {
            
            if let expirationDate = expirationDate, Date() < expirationDate, let token = KeychainHelper.getToken(for: tokenKey) {
                            // Token is still valid, fetch it from the keychain
                return token
                        } else {
                            // Token is expired or no expiration date, fetch a new one
                            fetchToken { result in
                                switch result {
                                case .success(let newToken):
                                    self.authToken = newToken
                                case .failure(let error):
                                    print("Failed to fetch new token: \(error)")
                                }
                            }
                            return nil
                        }
        }
        
        set {
            guard let newToken = newValue else { return }
                       // Store the new token securely in the keychain
                       KeychainHelper.save(token: newToken, for: tokenKey)
                       // Update the expiration date
                        expirationDate = Date().addingTimeInterval(40 * 60)
        }
    }
    private var expirationDate: Date?
    
    private init() {
        fetchToken { result in
            switch result {
            case .success(let newToken):
                self.authToken = newToken
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    // MARK: - Public Methods
    
    func fetchUsers(page:Int = 1, itemsPerPage: Int = 6, completion: @escaping (Result<[User], Error>) -> Void) {
        let url = baseURL + "/users"
        let parameters: [String: Any] = [
            "page": page,
            "count": itemsPerPage
        ]
        
        AF.request(url, method: .get, parameters: parameters).response { response in
            //general check if Alamofire succeded and we got any response
            switch response.result {
            case .success(let success):
                
                let data = response.data!
                
                do {
                    //check if we got positive respose or not
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let dict = jsonObject as? [String: Any], let sussess = dict["success"] as? Bool else {
                        return
                    }
                    
                    if sussess {
                        let usersResponce = try JSONDecoder().decode(UsersResponse.self, from: data)
                        completion(.success(usersResponce.users))
                    } else {
                        let errorResponce = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(NWManagerError.errorResponce(errorResponce)))
                    }
                }
                catch {
                    completion(.failure(NWManagerError.decodingError))
                }
            case .failure(let failure):
                completion(.failure(NWManagerError.networkError))
            }
            
        }
    }
    
    func fetchUser(id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        let url = baseURL + "/user/\(id)"
        
        AF.request(url, method: .get).response { response in
            //general check if Alamofire succeded and we got any response
            switch response.result {
            case .success(let success):
                
                let data = response.data!
                
                do {
                    //check if we got positive respose or not
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let dict = jsonObject as? [String: Any], let sussess = dict["success"] as? Bool else {
                        return
                    }
                    
                    if sussess {
                        let userResponce = try JSONDecoder().decode(UserResponse.self, from: data)
                        completion(.success(userResponce.user))
                    } else {
                        let errorResponce = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(NWManagerError.errorResponce(errorResponce)))
                    }
                }
                catch {
                    completion(.failure(NWManagerError.decodingError))
                }
            case .failure(let failure):
                completion(.failure(NWManagerError.networkError))
            }
            
        }
    }
    
    func fetchPositions(completion: @escaping (Result<[Position], Error>) -> Void) {
        let url = baseURL + "/positions"
        
        AF.request(url, method: .get).response { response in
            //general check if Alamofire succeded and we got any response
            switch response.result {
            case .success(let success):
                
                let data = response.data!
                
                do {
                    //check if we got positive respose or not
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let dict = jsonObject as? [String: Any], let sussess = dict["success"] as? Bool else {
                        return
                    }
                    
                    if sussess {
                        let positionsResponse = try JSONDecoder().decode(PositionsResponse.self, from: data)
                        completion(.success(positionsResponse.positions))
                    } else {
                        let errorResponce = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(NWManagerError.errorResponce(errorResponce)))
                    }
                }
                catch {
                    completion(.failure(NWManagerError.decodingError))
                }
            case .failure(let failure):
                completion(.failure(NWManagerError.networkError))
            }
            
        }
    }
    
    func fetchToken(completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL + "/token"
        
        AF.request(url, method: .get).response { response in
            //general check if Alamofire succeded and we got any response
            switch response.result {
            case .success(let success):
                
                let data = response.data!
                
                do {
                    //check if we got positive respose or not
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let dict = jsonObject as? [String: Any], let sussess = dict["success"] as? Bool else {
                        return
                    }
                    
                    if sussess {
                        let tokenResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                        completion(.success(tokenResponse.token))
                        
                    } else {
                        let errorResponce = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(NWManagerError.errorResponce(errorResponce)))
                        
                    }
                }
                catch {
                    completion(.failure(NWManagerError.decodingError))
                }
            case .failure(let failure):
                completion(.failure(NWManagerError.networkError))
            }
            
        }
    }
    
    
    
    func postUser(name: String,
                  email:String,
                  phone:String,
                  positionId: Int,
                  photoData: Data,
                  completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = baseURL + "/users"
        
        let headers: HTTPHeaders = [
            "token": authToken ?? "",
        ]
        
        let parameters: [String: Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "position_id": positionId
        ]
        
        let multipartFormData: MultipartFormData = MultipartFormData()
        
        // Append parameters to form data
        for (key, value) in parameters {
            multipartFormData.append(Data("\(value)".utf8), withName: key)
        }
        
        // Append photo data
        multipartFormData.append(photoData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
        
        
        AF.upload(multipartFormData: multipartFormData, to: url, headers: headers).response { response in
            //general check if Alamofire succeded and we got any response
            switch response.result {
            case .success(let success):
                
                let data = response.data!
                
                do {
                    //check if we got positive respose or not
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let dict = jsonObject as? [String: Any], let sussess = dict["success"] as? Bool else {
                        return
                    }
                    
                    if sussess {
                        let usersResponce = try JSONDecoder().decode(UsersResponse.self, from: data)
                        completion(.success(true))
                    } else {
                        let errorResponce = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(NWManagerError.errorResponce(errorResponce)))
                    }
                }
                catch {
                    completion(.failure(NWManagerError.decodingError))
                }
            case .failure(let failure):
                completion(.failure(NWManagerError.networkError))
            }
            
        }
    }
}

