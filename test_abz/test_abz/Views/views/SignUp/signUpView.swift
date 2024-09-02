//
//  signUpView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI
import PhotosUI

struct SignupView: View {
    
    @StateObject var viewModel: SignUpVM

    
    @State private var showImagePicker: Bool = false
    @State private var showCamera = false
    @State private var showGallery = false
    
    @State private var validationError: String? = nil
    
    @State var imageName: String = ""
    
    
    var body: some View {
        
        ScrollView(showsIndicators: false){
            VStack( spacing: 24){
                VStack(spacing: 32) {
                    CustomTextField(
                        validationResult: $viewModel.nameValidationResult,
                        placeholder:  "Your name",
                        text: $viewModel.name
                    )
                    CustomTextField(
                        validationResult: $viewModel.emailValidationResult,
                        placeholder:  "Email",
                        text: $viewModel.email
                    )
                    CustomTextField(
                        subText: "+38 (XXX) XXX - XX - XX",
                        validationResult: $viewModel.phoneValidationResult,
                        placeholder:  "Phone",
                        text: $viewModel.phone
                    )
                }
                
                Text("Select your position")
                    .font(UIConstraints.fontRegular(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                    RadioButtonGroup<Position>(items: $viewModel.positions) { selected in
                        viewModel.selectedPosition = viewModel.positions.first { $0.name == selected }
                    }
                
                
                ZStack(alignment: .topTrailing) {
                    CustomTextField(
                        subText: "Min 70x70px, less then 5 MB, jpeg/jpg type",
                        validationResult: $viewModel.photoValidationResult,
                        placeholder: (viewModel.photoName.isEmpty ? "Upload your photo" : "Image"),
                        text: $viewModel.photoName
                    ).disabled(true)
                    
                    Button {
                        showImagePicker = true
                    } label: {
                        Text("Upload")
                            .padding(.top, 5)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                    .buttonStyle(PrimaryButtonStyle())
                    .confirmationDialog("Choose how you want to add a photo", isPresented: $showImagePicker) {
                        
                        Button("Camera") {
                            showCamera = true
                        }
                        .disabled(!UIImagePickerController.isSourceTypeAvailable(.camera))
                        
                        Button("Gallery") {
                            showGallery = true
                        }
                    } message: {
                        Text("Choose how you want to add a photo")
                    }
                    .sheet(isPresented: $showCamera) {
                        CameraPicker(selectedImage: $viewModel.photo, name: $viewModel.photoName)
                    }
                    .sheet(isPresented: $showGallery) {
                        PhotoPicker(selection: $viewModel.photo, name: $viewModel.photoName)
                    }
                }
                
                Button {
                    viewModel.signUp()
                } label: {
                    Text("Sign up")
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!viewModel.allValid)
                Spacer()
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 16)
        }
        
        
    }
    
    
    
}



struct ContentView_Previews4: PreviewProvider {
    struct Wrapper: View {
        @State private var isPresented: UIImage? = UIImage(named: "photo-cover")
        @StateObject var vm = SignUpVM()
        
        var body: some View {
            
            SignupView(viewModel: vm)
            
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}


struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
