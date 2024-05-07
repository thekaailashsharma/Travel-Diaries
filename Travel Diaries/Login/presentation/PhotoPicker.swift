//
//  PhotoPicker.swift
//  Travel Diaries
//
//  Created by Kailash on 05/05/24.
//

import Foundation
import PhotosUI
import Photos
import SwiftUI

@MainActor
final class PhotoPickerViewController: ObservableObject {
    
    @Published var notAccessGranted: Bool = true
    @Published var authStatus: PHAuthorizationStatus = .notDetermined
    
    @Published private(set) var selectedImage: UIImage? = nil
    @Published var imageSelection: PhotosPickerItem? =  nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    init() {
        self.notAccessGranted = !checkPhotoLibraryAuthorization()
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task {
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    return
                }
            }
        }
    }
    
    
    private func redirectToAppSettingsIfNeeded() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .denied || status == .restricted {
            redirectToAppSettings()
        }
    }

    private func redirectToAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(settingsURL)
    }
    
    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.authStatus = status
                switch status {
                case .authorized:
                    self.notAccessGranted = false
                    print("Yayyy")
                case .limited:
                    // Limited access granted
                    self.notAccessGranted = true
                    print("Limited Access")
                case .denied, .restricted:
                    // Access denied or restricted
                    self.redirectToAppSettingsIfNeeded()
                    self.notAccessGranted = true
                    print("Access Denied")
                default:
                    break
                }
            }
        }
    }
    
    func checkPhotoLibraryAuthorization() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            return true
        case .limited:
            // Limited access granted
            return true
        case .denied, .restricted:
            // Access denied or restricted
            return false
        case .notDetermined:
            // User has not yet made a choice
            return false
        @unknown default:
            return false
        }
    }
        
}

struct PhotoPicker: View {
    
    var path: String
    var OnSuccess: () -> Void
    @EnvironmentObject var storageManager: StorageManager
    @EnvironmentObject var loginViewModel: LoginViewModel
    @StateObject var photoPicker = PhotoPickerViewController()
    @State private var selectedImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 30) {
            
            if let uploadStatus = storageManager.uploadStatus {
                switch uploadStatus {
                case .inProgress(let progress):
                    ProgressView("Uploading...", value: progress, total: 100)
                        .foregroundColor(Color.customColor(.green))
                case .success(let url):
                    Text("Upload Success")
                        .foregroundColor(Color.customColor(.green))
                        .font(.customFont(.poppins, size: 10))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation(.bouncy(duration: 1)) {
                                    loginViewModel.profilePictureUrl = url
                                    OnSuccess()
                                }
                            }
                        }
                case .failure(let error):
                    Text("Upload Failed: \(error.localizedDescription)")
                        .foregroundColor(Color.customColor(.pink))
                        .font(.customFont(.poppins, size: 10))
                }
            }
            
            
            Spacer()
            if let image = photoPicker.selectedImage {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.customColor(.white), lineWidth: 1.0)
                    )
                    .frame(width: 250, height: 250)
                    .shadow(radius: 5)
                
                    
            } else {
                ContentUnavailableView("Choose An Image", systemImage: "photo.on.rectangle.angled")
                    .foregroundStyle(Color.customColor(.green))
            }
            
            PhotosPicker(selection: $photoPicker.imageSelection, matching: .images) {
                
                Text("Pick A Profile Photo")
                    .font(.customFont(.poppins, size: 20))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .black).opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customColor(.green).opacity(0.5))
                    }
                
                
            }
            if let image = photoPicker.selectedImage {
                Button {
                    selectedImage = image
                    storageManager.upload(image: image, path: path)
                } label: {
                    Text("Upload & Proceed")
                        .font(.customFont(.poppins, size: 20))
                        .foregroundStyle(Color.customColor(.white))
                        .padding()
                        .frame(width: 300)
                        .background(Color.customColor(.green).opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.white.opacity(0.5))
                        }
                }
            }

            
            

            
            Spacer()
        }
        .padding()
    }
}

struct MetadataPhotoPicker : View {
    
    var onUpload: () -> Void
    @StateObject var photoPickerConntroller = PhotoPickerViewController()
    @State var showSheet = false
    @Binding var selectedImage: UIImage?
    @Binding var date: Date?
    @Binding var location: CLLocationCoordinate2D?
    
    var body: some View {
//        let _ = print("Access is \(photoPickerConntroller.accessGranted)")
        VStack {
            Spacer()
            if let image = selectedImage {
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay(
                        Circle().stroke(.white, lineWidth: 1.0)
                    )
                    .frame(width: 250, height: 250)
                    .shadow(radius: 5)
                    
            } else {
                ContentUnavailableView("Choose An Image", systemImage: "photo.on.rectangle.angled")
            }
            
            Spacer()
            
            Button {
                showSheet = true
            } label: {
                
                Text("Pick A Profile Photo")
                    .font(.customFont(.poppins, size: 20))
                    .foregroundStyle(.white)
                    .padding()
                    .frame(width: 300)
                    .background(Color(uiColor: .black).opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white.opacity(0.5))
                    }
                
                
            }
            Spacer()
        }
        .sheet(isPresented: $showSheet, content: {
            CustomPhotoPickerView(selectedImage: $selectedImage, date: $date, location: $location)
        })
        .fullScreenCover(isPresented: $photoPickerConntroller.notAccessGranted) {
            PermissionsCard()
                .environmentObject(photoPickerConntroller)
        }
        .padding()
    }
}
