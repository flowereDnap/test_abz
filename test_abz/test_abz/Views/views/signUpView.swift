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
    //TODO VM
    @ObservedObject var viewModel: SignUpVM
    
    @State private var selectedPos = ""
    
    @Binding var selectedImage: UIImage?
    @State private var showImagePicker: Bool = false
    @State private var showCamera = false
    @State private var showGallery = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var validationError: String? = nil
    
    private let minResolution: CGSize = CGSize(width: 70, height: 70)
    private let maxSizeMB: CGFloat = 5
    
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
                
                ZStack(alignment: .topTrailing) {
                    CustomTextField(
                        subText: "Min 70x70px, less then 5 MB, jpeg/jpg type",
                        validationREsult: viewModel.$photoValidationResult,
                        placeholder:  "Upload your photo",
                        text: viewModel.$name//TODO insert photo name
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
                        CameraPicker(selectedImage: $selectedImage)
                    }
                    .sheet(isPresented: $showGallery) {
                        PhotoPicker(selection: $selectedImage)
                    }
                }
                
                Button {
                    
                } label: {
                    Text("Sign up")
                }
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
                            //imageValid
                        } else {
                            selectedImage = nil
                            //imageValid = false
                        }
                    }
                }
            }
        }
        
        
    }
    
    
    private func validateImage(_ image: UIImage, dataSize: Int) -> Bool {
        let imageSize = image.size
        let fileSizeMB = CGFloat(dataSize) / (1024 * 1024)
        
        if imageSize.width < minResolution.width || imageSize.height < minResolution.height {
            validationError = "Image resolution must be at least \(Int(minResolution.width))x\(Int(minResolution.height)) pixels."
            return false
        }
        
        if fileSizeMB > maxSizeMB {
            validationError = "Image size must not exceed \(Int(maxSizeMB))MB."
            return false
        }
        
        return true
    }
}



struct ContentView_Previews4: PreviewProvider {
    struct Wrapper: View {
        @State private var isPresented: UIImage? = UIImage(named: "photo-cover")
        
        
        var body: some View {
            
            SignupView(viewModel: SignUpVM(), selectedImage: $isPresented)
            
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}

