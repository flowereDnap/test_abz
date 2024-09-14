//
//  Model.swift
//  test_abz
//
//  Created by mac on 12.09.2024.
//

import Foundation
import SwiftUI


class Model: ObservableObject {
    @Published public var users: [User] = []
    private var currentPage: Int = 1
    private let itemsPerPage: Int = 6
    private let cacheManager = CacheImageManager()
    
    @Published var positions: [Position] = []
    @Published var awaitingResponce: Bool = false
    
    init() {
        fetchPositions()
    }
    
    func fetchPositions() {
        NWManager.shared.fetchPositions { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedPositions):
                positions = fetchedPositions
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchNextPage( completion: @escaping (Bool) -> Void) {
        awaitingResponce = true
        
        NWManager.shared.fetchUsers(page: currentPage, itemsPerPage: itemsPerPage) { [weak self] result in
            self?.awaitingResponce = false
            print("fetch page", self?.awaitingResponce)
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedUsers):
                self.users.append(contentsOf: fetchedUsers)
                self.currentPage += 1
                completion(true)
            case .failure(_):
             
                completion(false)
            }
        }
    }
    
    func fetchUserImage(for user: User, bindingImage: Binding<UIImage>) {
        
        if let cachedImage = cacheManager.getImage(forKey: user.photo) {
            bindingImage.wrappedValue = cachedImage
            return
        }
        
        // If not in cache, fetch from server
        NWManager.shared.fetchImage(from: user.photo) { [weak self] result in
            switch result {
            case .success(let downloadedImage):
                DispatchQueue.main.async {
                    self?.cacheManager.cacheImage(downloadedImage, forKey: user.photo)
                    bindingImage.wrappedValue = downloadedImage
                }
            case .failure(let error):
                print(error)
                break
            }
            
            
        }
    }
    
    func postUser(name: String,
                  email: String,
                  phone: String,
                  positionId: Int,
                  photoData: Data,
                  complition: @escaping (Result<Int, NWManagerError>)->Void) {
        awaitingResponce = true
        
        NWManager.shared.postUser(name: name, email: email, phone: phone, positionId: positionId, photoData: photoData) {  [weak self] result in
            self?.awaitingResponce = false
            
            complition(result)
            
            switch result {
            case .success(let id):
                self?.getUser(with: id) { [weak self] result in
                    
                    switch result {
                    case .success(let userResponce):
                        self?.users.insert(userResponce.user, at: 0)
                    case .failure(_):
                        return
                    }
                    
                }
            case .failure(_):
                return
            }
            
            
        }
    }
    
    func getUser(with id: Int, complition: @escaping (Result<GetUserResponse, Error>) -> Void) {
        awaitingResponce = true
        
        NWManager.shared.fetchUser(id: id) { [weak self] result in
            self?.awaitingResponce = false
            complition(result)
        }
    }
    
}
