import Foundation
import Combine
import FirebaseStorage
import SwiftUI

enum UploadStatus {
    case inProgress(Double) // Progress percentage
    case success(URL) // Uploaded URL
    case failure(Error) // Upload failure
}

@MainActor
class StorageManager: ObservableObject {
    let storage = Storage.storage()
    @Published var uploadStatus: UploadStatus?
    @Published var uploadedImageUrl: URL?
    
    func upload(image: UIImage, path: String) {
        let storageRef = storage.reference().child(path)
        let data = image.jpegData(compressionQuality: 0.2)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        if let data = data {
            let uploadTask = storageRef.putData(data, metadata: metadata) { [weak self] (metadata, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error while uploading file: ", error)
                    self.uploadStatus = .failure(error)
                }
                
                if let metadata = metadata {
                    storageRef.downloadURL { url, error in
                        if let error = error {
                            print("Error while retrieving download URL: ", error)
                            self.uploadStatus = .failure(error)
                        } else if let url = url {
                            self.uploadedImageUrl = url
                            self.uploadStatus = .success(url)
                        }
                    }
                }
            }
            
            uploadTask.observe(.progress) { snapshot in
                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
                self.uploadStatus = .inProgress(percentComplete)
            }
        }
    }
}
