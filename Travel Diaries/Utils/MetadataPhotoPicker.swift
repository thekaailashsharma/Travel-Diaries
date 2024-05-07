//
//  MetadataPhotoPicker.swift
//  Travel Diaries
//
//  Created by Kailash on 07/05/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct CustomPhotoPickerView: UIViewControllerRepresentable {
        
    @Binding var selectedImage: UIImage?
    @Binding var date: Date?
    @Binding var location: CLLocationCoordinate2D?
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func makeCoordinator() -> CustomPhotoPickerView.Coordinator {
        return Coordinator(self)
    }
    
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            guard !results.isEmpty else {
                return
            }
            
            let imageResult = results[0]
            
            if let assetId = imageResult.assetIdentifier {
                let assetResults = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil)
                let asset = assetResults.firstObject
                
                if let asset = asset {
                    asset.requestContentEditingInput(with: nil) { contentEditingInput, _ in
                        if let date = contentEditingInput?.creationDate {
                            DispatchQueue.main.async {
                                self.parent.date = date
                            }
                        }
                    }
                    
                    if let location = asset.location {
                        DispatchQueue.main.async {
                            self.parent.location = location.coordinate
                        }
                    }
                }
            }
            
            if imageResult.itemProvider.canLoadObject(ofClass: UIImage.self) {
                imageResult.itemProvider.loadObject(ofClass: UIImage.self) { (selectedImage, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self.parent.selectedImage = selectedImage as? UIImage
                        }
                    }
                }
            }
        }
        
        private let parent: CustomPhotoPickerView
        init(_ parent: CustomPhotoPickerView) {
            self.parent = parent
        }
    }

}
