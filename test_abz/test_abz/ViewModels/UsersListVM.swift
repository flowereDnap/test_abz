import Foundation
import SwiftUI

class UsersListVM: ObservableObject {
    
    private var model: Model
    @ObservedObject var alertVM: AlertVM
    
    @Published var users: [User] = []
    @Published var loading: Bool = false
    
    init(alertVM: AlertVM, model: Model) {
        self.alertVM = alertVM
        self.model = model
        
        self.users = model.users
        model.$users.assign(to: &$users)
        
        self.loading = model.awaitingResponce
        model.$awaitingResponce.assign(to: &$loading)
    }
    
    func fetchNextPage(completion: @escaping () -> Void) {
        model.fetchNextPage { success in
            if success {
                completion()
            } else {
                self.alertVM.type = .noConnection
                self.alertVM.supportingText = nil
                self.alertVM.isPresented = true
                
            }
        }
    }
    
    func fetchUserImage(for user: User, bindingImage: Binding<UIImage>) {
        model.fetchUserImage(for: user, bindingImage: bindingImage)
    }
}
