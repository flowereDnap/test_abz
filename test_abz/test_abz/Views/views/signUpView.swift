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
    @State var text1: String = ""
    @State var text2: String = ""
    @State var text3: String = ""
    var nameFieldValidation: (String) -> (Bool, String) = { return (!$0.isEmpty , "Required field")}
    
    var emailFieldValidation: (String) -> (Bool, String) = { if $0.isEmpty {
        return (!$0.isEmpty , "Required field")
    } else {
        return (!$0.isEmpty , "Required field")
    }
    }
    
    var phoneFieldValidation: (String) -> (Bool, String) = { if $0.isEmpty {
        return (!$0.isEmpty , "Required field")
    } else {
        return (!$0.isEmpty , "Required field")
    }
    }
    
    @State private var selectedPos = ""
    var positions: [String] = ["yes", "no", "aboba"]
    
    var body: some View {
        VStack( spacing: 24){
            VStack(spacing: 32) {
                CustomTextField(
                    validate: nameFieldValidation,
                    placeholder:  "Your name",
                    text: $text1
                )
                CustomTextField(
                    validate: emailFieldValidation,
                    placeholder:  "Email",
                    text: $text2
                )
                CustomTextField(
                    subText: "+38 (XXX) XXX - XX - XX",
                    validate: phoneFieldValidation,
                    placeholder:  "Phone",
                    text: $text3
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
                    validate: nameFieldValidation,
                    placeholder:  "Your name",
                    text: $text1
                )
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
    
    
    struct ContentView_Previews4: PreviewProvider {
        static var previews: some View {
            SignupView()
        }
    }
    
    
