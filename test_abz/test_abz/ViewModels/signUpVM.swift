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
    @Published var phone: String = ""
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
    
    @Published var nameValidationResult: (Bool, String) = (true, " ")
    @Published var emailValidationResult: (Bool, String) = (true, " ")
    @Published var phoneValidationResult: (Bool, String) = (true, " ")
    @Published var photoValidationResult: (Bool, String) = (true, " ")
    
    private let minResolution: CGSize = CGSize(width: 70, height: 70)
    private let maxSizeMB = 5
    
    var alertView: Binding<ModalAlertView>?
   
   init(alertView: Binding<ModalAlertView>) {
       self.alertView = alertView
       fetchPositions()
   }
    
    init() {
        fetchPositions()
    }
    
    
    
    func nameFieldValidation() {
        nameValidationResult = (!name.isEmpty , "Required field")
        updAllValid()
    }
    
    func emailFieldValidation() {
        if email.isEmpty {
            emailValidationResult =  ( false , "Required field")
        } else {
            
            let emailRegEx = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
            let emailPred = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            
            emailValidationResult = ( emailPred.evaluate(with: email) , "Wrong email")
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
            
            phoneValidationResult = ((phone.hasPrefix("+380") && phone.count == 13) , "Wrong number")
        }
        
        updAllValid()
    }
    
    func photoFieldValidation() {
        
        guard let photo = photo else {
            photoValidationResult = (false , "Required field")
            updAllValid()
            return
        }
        
        
        //TODO
        let imageSize = photo.size
        guard let imageData = photo.jpegData(compressionQuality: 1.0) else {
            photoValidationResult = (false , "Photo has to be jpeg/jpg type")
            self.photo = nil
            updAllValid()
            return
        }
        let fileSizeMB = imageData.count / (1024*1024)
        
        if imageSize.width < minResolution.width || imageSize.height < minResolution.height {
            photoValidationResult = (false , "70x70px minimal quality required")
            self.photo = nil
            updAllValid()
            return
        }
        
        if fileSizeMB > maxSizeMB {
            photoValidationResult = (false , "The photo's size has to be less then 5MB")
            self.photo = nil
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
    
    func signUp() {
        updAllValid()
        if allValid {
            NWManager.shared.postUser(name: name, email: email, phone: phone, positionId: selectedPosition!.id, photoData: photo!.jpegData(compressionQuality: 1)!) { result in
                switch result {
                case .success(let success):
                    self.alertView?.type.wrappedValue = .signUpSuccess
                    self.alertView?.isPresented.wrappedValue?.wrappedValue = true
                case .failure(let error):

                    
                    
                    switch error {
                    case .errorResponce(let errorDesc):
                        self.alertView = ModalAlertView(type: .signUpFail, supportingText: errorDesc.message, isPresented: <#T##Binding<Bool>?#>, complition: <#T##() -> Void#>)
                        self.alertView?.supportingText.wrappedValue = string
                    case .networkError:
                        self.alertView?.type.wrappedValue = .noConnection
                        self.alertView?
                    }
                    
                    self.alertView?.isPresented.wrappedValue?.wrappedValue = true
                }
            }
        }
    }
}
