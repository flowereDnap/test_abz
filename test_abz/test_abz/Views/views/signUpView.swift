//
//  signUpView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI

struct SignupView: View {
    //TODO VM
    @ObservedObject var viewModel: SignUpVM
    
    @State private var selectedPos = ""
    var positions: [String] = ["yes", "no", "aboba"]
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack( spacing: 24){
                VStack(spacing: 32) {
                    CustomTextField(
                        validationREsult: viewModel.$nameValidationResult,
                        placeholder:  "Your name",
                        text: viewModel.$name
                    )
                    CustomTextField(
                        validationREsult: viewModel.$phoneValidationResult,
                        placeholder:  "Email",
                        text: viewModel.$email
                    )
                    CustomTextField(
                        subText: "+38 (XXX) XXX - XX - XX",
                        validationREsult: viewModel.$phoneValidationResult,
                        placeholder:  "Phone",
                        text: viewModel.$phone
                    )
                }
                
                Text("Select your position")
                    .font(UIConstraints.fontRegular(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RadioButtonGroup(items: positions) { selected in
                    selectedPos = selected
                }
                
                ZStack {
                    CustomTextField(
                        subText: "Photo size < 5 MB",
                        validationREsult: viewModel.$photoValidationResult,
                        placeholder:  "Upload your photo",
                        text: viewModel.$name//TODO insert photo name
                    ).disabled(true)
                    
                    Button {
                        
                    } label: {
                        Text("select")
                    }
                    
                }
                //TODO picker
                Button {
                    
                } label: {
                    Text("Sign Up")
                }.buttonStyle(PrimaryButtonStyle())
                
                Spacer()
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
        }
    }
}


struct ContentView_Previews4: PreviewProvider {
    static var previews: some View {
        SignupView(viewModel: SignUpVM())
    }
}


