//
//  PhotoAccessHelper.swift
//  UZIAdmin
//
//  Created by SEAN BLAKE on 2/3/24.
//

import SwiftUI
import PhotosUI
import UIKit

class PhotoAccessHelper: NSObject, ObservableObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Published var image: UIImage?
    @Published var showingPicker: Bool = false // This will trigger the sheet presentation
    private var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    
    func requestPhotoPicker() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
        // Implementation to show photo picker and handle selection...
        showingPicker = true // This would typically be set to true after the user selects an image or takes a photo
        
    }
    
    func requestCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        UIApplication.shared.windows.first?.rootViewController?.present(picker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let provider = results.first?.itemProvider else { return }
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    self.image = image as? UIImage
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    func checkCameraPermissions(completion: @escaping (Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        default:
            completion(false)
        }
    }
}

