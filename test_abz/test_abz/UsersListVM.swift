import Foundation
import SwiftUI

class UsersListVM: ObservableObject {
    @Published var users: [User] = []
    private var currentPage: Int = 1
    private let itemsPerPage: Int = 6
    private let cacheManager = CacheImageManager()

     var isPresented: Binding<Bool>?
     var alertType: Binding<AlertType>?
    
    init(isPresented: Binding<Bool>, alertType: Binding<AlertType>) {
        self.isPresented = isPresented
        self.alertType = alertType
    }
    
    init() {
        
    }

    func fetchNextPage() {
        NWManager.shared.fetchUsers(page: currentPage + 1, itemsPerPage: itemsPerPage) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let fetchedUsers):
                self.users.append(contentsOf: fetchedUsers)
                self.currentPage += 1
                
            case .failure(_):
                alertType?.wrappedValue = .noConnection
                isPresented?.wrappedValue = true
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
}
