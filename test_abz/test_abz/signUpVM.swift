import Foundation
import SwiftUI

class SignUpVM: ObservableObject {
    @State var name: String = "" {
        didSet {
            nameFieldValidation()
        }
    }
    @State var email: String = ""
    @State var phone: String = ""
    @State var photo: UIImage?
    
    @State var chosenPosition: String = ""
    
    @State var nameValidationResult: (Bool, String) = (true, " ")
    @State var emailValidationResult: (Bool, String) = (true, " ")
    @State var phoneValidationResult: (Bool, String) = (true, " ")
    @State var photoValidationResult: (Bool, String) = (true, " ")
    
    
    
    func nameFieldValidation() {
        nameValidationResult = (!name.isEmpty , "Required field")
    }
    
    func emailFieldValidation() {
        if email.isEmpty {
            emailValidationResult =  ( false , "Required field")
        } else {
            //TODO
            emailValidationResult = (!email.isEmpty , "Required field")
        }
    }
    
    func phoneFieldValidation() {
        if phone.isEmpty {
            phoneValidationResult = (false , "Required field")
        } else {
            //TODO
            phoneValidationResult = (!phone.isEmpty , "Required field")
        }
    }
    
    func photoFieldValidation() {
        if photo == nil {
            photoValidationResult = (false , "Required field")
        } else {
            //TODO
            photoValidationResult = (!phone.isEmpty , "Required field")
        }
    }
}
