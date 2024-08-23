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
    @State private var isPickerPresented: Bool = false
    @State private var selectedItem: PhotosPickerItem? = nil

    var validateImage : (UIImage, Int) -> Bool

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
                    isValid: nameValid,
                    placeholder:  "Your name",
                    text: $text1
                )
                CustomTextField(
                    isValid: emailValid,
                    placeholder:  "Email",
                    text: $text2
                )
                CustomTextField(
                    subText: "+38 (XXX) XXX - XX - XX",
                    isValid: phoneValid,
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
                    isValid: $imageValid,
                    placeholder:  "Your name",
                    text: $text1
                )
            }
                //TODO picker
            Button("Select Photo") {
                isPickerPresented = true
            }
            .photosPicker(isPresented: $isPickerPresented, selection: $selectedItem, matching: .images)
            .buttonStyle(PrimaryButtonStyle())
                
                Spacer()
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
.onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    if validateImage(uiImage, dataSize: data.count) {
                        selectedImage = uiImage
                        imageValid
                    } else {
                        selectedImage = nil
                        imageValid = false
                    }
                }
            }
        }
        }
    }
    
    
    struct ContentView_Previews4: PreviewProvider {
        static var previews: some View {
            SignupView()
        }
    }
    
    
