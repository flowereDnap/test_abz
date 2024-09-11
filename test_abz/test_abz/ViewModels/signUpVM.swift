import Foundation
import SwiftUI

class SignUpVM: ObservableObject {
    @Published var name: String = "" {
        didSet {
            nameFieldValidation()
        }
    }
    @Published var email: String = ""
    {
        didSet {
            emailFieldValidation()
        }
    }
    @Published var phone: String = "+380"
    {
        didSet {
            phoneFieldValidation()
        }
    }
    @Published var photoName: String = ""
    {
        didSet {
            photoFieldValidation()
        }
    }
    
    @Published var photo: UIImage?
    {
        didSet {
            photoFieldValidation()
        }
    }
    
    @Published var allValid = false
    
    func updAllValid(){
        allValid = (nameValidationResult.0 && emailValidationResult.0 && phoneValidationResult.0 && photoValidationResult.0 && selectedPosition != nil)
    }
    
    @Published var positions: [Position] = []
    
    @Published var selectedPosition: Position? = nil {
        didSet {
            updAllValid()
        }
    }
    
    @Published var nameValidationResult: (Bool, String) = (false, "")
    @Published var emailValidationResult: (Bool, String) = (false, "")
    @Published var phoneValidationResult: (Bool, String) = (false, "")
    @Published var photoValidationResult: (Bool, String) = (false, "")
    
    private let minResolution: CGSize = CGSize(width: 70, height: 70)
    private let maxSizeMB = 5.0
    
    @ObservedObject var alertVM: AlertVM
    
    init(alertVM: AlertVM) {
        self.alertVM = alertVM
        fetchPositions()
    }
    
    
    func nameFieldValidation() {
        if name.isEmpty {
            nameValidationResult = ( false  , "Required field")
            updAllValid()
            return
        }
        nameValidationResult = ( name.count > 1  , "At least 2 characters")
        updAllValid()
    }
    
    func emailFieldValidation() {
        let cleared = email.lowercased()
        
        if cleared != email {
            email = cleared
            return
        }
        
        if email.isEmpty {
            emailValidationResult =  ( false , "Required field")
        } else {
            
            let emailRegEx = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
            let emailPred = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            
            emailValidationResult = ( emailPred.evaluate(with: email) , "Wrong email format")
        }
        updAllValid()
    }
    
    func phoneFieldValidation() {
        let cleared = phone.replacingOccurrences(of: " ", with: "")
        
        if cleared != phone {
            phone = cleared
            return
        }
        
        if phone.isEmpty {
            phoneValidationResult = (false , "Required field")
        } else {
            
            phoneValidationResult = ((phone.hasPrefix("+380") && phone.count == 13) , "Wrong number format")
        }
        
        updAllValid()
    }
    
    func photoFieldValidation() {
        
        guard let photo = photo else {
            photoValidationResult = (false , "Photo is required")
            updAllValid()
            return
        }
        
        
        //TODO
        let imageSize = photo.size
        guard let imageData = photo.jpegData(compressionQuality: 1.0) else {
            photoValidationResult = (false , "Photo has to be jpeg/jpg type")
            updAllValid()
            return
        }
        let fileSizeMB: Double = Double(imageData.count) / (1024*1024)
        
        if imageSize.width < minResolution.width || imageSize.height < minResolution.height {
            photoValidationResult = (false , "70x70px minimal quality required")
            updAllValid()
            return
        }
        
        
        if fileSizeMB >= maxSizeMB {
            photoValidationResult = (false , "The photo's size has to be less then 5MB")
            updAllValid()
        
            return
        }
        
        photoValidationResult = (true , " ")
        updAllValid()
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
    
    func signUp(completion: @escaping () -> Void) {
        updAllValid()
        if allValid {
            NWManager.shared.postUser(name: name, email: email, phone: phone, positionId: selectedPosition!.id, photoData: photo!.jpegData(compressionQuality: 1)!) { result in
                switch result {
                case .success(let success):
                    self.alertVM.type = .signUpSuccess
                    self.alertVM.supportingText = nil
                    self.alertVM.isPresented = true
                    
                case .failure(let error):
                    switch error {
                    case .errorResponce(let errorDesc):
                        self.alertVM.type = .signUpFail
                        self.alertVM.supportingText = errorDesc.fails?.first?.value.first
                    case .networkError:
                        self.alertVM.type = .noConnection
                        self.alertVM.supportingText = nil
                    default:
                        self.alertVM.type = .signUpFail
                        self.alertVM.supportingText = nil
                    }
                }
                completion()
                self.alertVM.isPresented = true
            }
            
        }
    }
}
