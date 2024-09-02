//
//  NoConnectionAlertView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI

enum AlertType {
    case noConnection
    case signUpSuccess
    case signUpFail
}

struct ModalAlertView: View {
    
    var type: AlertType = .noConnection
    
    var isPresented: Binding<Bool>?
    
    
    
    var supportingText: String? = nil
    
    var imageName: String {
        switch type {
        case .noConnection:
            return "no-connection-image"
        case .signUpSuccess:
            return "signUp-success-image"
        case .signUpFail:
            return "signUp-fail-image"
        }
    }
    
    var buttonText: String {
        switch type {
        case .noConnection:
            return "Try again"
        case .signUpSuccess:
            return "Got it"
        case .signUpFail:
            return "Try again"
        }
    }
    
    var completion: ()->Void
    
    var displayText: String {
        if let supportingText = supportingText {
            return supportingText
        } else {
            switch type {
            case .noConnection:
                return "There is no internet Connection"
            case .signUpSuccess:
                return "User successfully registered"
            case .signUpFail:
                return "Something went wrong, try again later"
            }
        }
    }
    
    init(isPresented: Binding<Bool>?, complition: @escaping ()->Void) {
        
        self.isPresented = isPresented
        self.completion = complition
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            HStack {
                Spacer()
                Button(action: {
                    isPresented?.wrappedValue = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
                .padding()
            }
            
            VStack(alignment: .center, spacing: 24) {
                
                Spacer()
                Image(imageName)
                Text(displayText)
                    .font(UIConstraints.fontRegular(size: 20))
                Button {
                    isPresented?.wrappedValue = false
                    completion()
                } label: {
                    Text(buttonText)
                        
                }.buttonStyle(PrimaryButtonStyle())
                Spacer()
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity
                )
        }
    }
}



struct InputTextField_Previews2: PreviewProvider {
    struct Wrapper: View {
        @State var bool = true
        
        var body: some View {
            ModalAlertView(isPresented: $bool) {
            }
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}

