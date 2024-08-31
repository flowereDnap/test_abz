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
    
    @State var type: AlertType
    @Binding var isPresented: Bool
    
    
    
    var supportingText: String = ""
    var imageName: String = ""
    var buttonText: String = ""
    
    var completion: ()->Void
    
    init(type: AlertType, supportingText: String?, isPresented: Binding<Bool>, complition: @escaping ()->Void) {
        self.type = type
        self.supportingText = supportingText ?? " "
        
        if let supportingText = supportingText {
            self.supportingText = supportingText
        } else {
            switch type {
            case .noConnection:
                self.supportingText = "There is no internet Connection"
                self.imageName = "no-connection-image"
                self.buttonText = "Try again"
            case .signUpSuccess:
                self.supportingText = "User successfully registered"
                self.imageName = "signUp-success-image"
                self.buttonText = "Got it"
            case .signUpFail:
                self.supportingText = ""
                self.imageName = "signUp-fail-image"
                self.buttonText = "Try again"
            }
        }
        self._isPresented = isPresented
        self.completion = complition
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Spacer()
                            Button(action: {
                                isPresented = false
                            }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .clipShape(Circle())
                            }
                            .padding()
                        }
            Spacer()
            Image(imageName)
            Text(supportingText)
            Button {
                isPresented = false
                completion()
            } label: {
                Text(buttonText)
            }.buttonStyle(PrimaryButtonStyle())
            Spacer()
        }
    }
}



struct InputTextField_Previews2: PreviewProvider {
    struct Wrapper: View {
        @State var bool = true

        var body: some View {
            ModalAlertView(type: .noConnection, supportingText: nil, isPresented: $bool) {
            }
        }
    }

    static var previews: some View {
        Wrapper()
    }
}

