//
//  GalleryPicker.swift
//  test_abz
//
//  Created by mac on 31.08.2024.
//

import Foundation
import PhotosUI
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var selection: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: PHPickerViewControllerDelegate {
        let parent: PhotoPicker

        init(_ parent: PhotoPicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selection = nil
            picker.dismiss(animated: true, completion: nil)
            
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                    self?.parent.selection = image as? UIImage
                }
            }
        }
    }
}

