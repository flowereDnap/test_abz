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
    
    @StateObject var viewModel: AlertVM
    
    
    var imageName: String {
        switch viewModel.type {
        case .noConnection:
            return "no-connection-image"
        case .signUpSuccess:
            return "signUp-success-image"
        case .signUpFail:
            return "signUp-fail-image"
        }
    }
    
    var buttonText: String {
        switch viewModel.type {
        case .noConnection:
            return "Try again"
        case .signUpSuccess:
            return "Got it"
        case .signUpFail:
            return "Try again"
        }
    }
    
    var displayText: String {
        if let supportingText = viewModel.supportingText {
            return supportingText
        } else {
            switch viewModel.type {
            case .noConnection:
                return "There is no internet Connection"
            case .signUpSuccess:
                return "User successfully registered"
            case .signUpFail:
                return "Something went wrong, try again later"
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing){
            HStack {
                Spacer()
                Button(action: {
                    viewModel.isPresented = false
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
                    viewModel.isPresented = false
                    viewModel.complition()
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
        @StateObject var vm = AlertVM()
        
        var body: some View {
            ModalAlertView(viewModel: vm)
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}

