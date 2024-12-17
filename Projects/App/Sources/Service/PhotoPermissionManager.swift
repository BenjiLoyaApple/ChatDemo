//
//  PhotoPermissionManager.swift
//  ChatDemo
//
//  Created by Benji Loya on 17.12.2024.
//

import SwiftUI
import Photos

// Менеджер для проверки статуса доступа к Фото
class PhotoPermissionManager: ObservableObject {
    @Published var photoPermissionStatus: String = "Checking..."
    
    init() {
        checkPhotoLibraryPermission()
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.photoPermissionStatus = "Full Access"
        case .limited:
            self.photoPermissionStatus = "Limited Access"
        case .denied, .restricted:
            self.photoPermissionStatus = "No Access"
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized {
                        self.photoPermissionStatus = "Full Access"
                    } else if newStatus == .limited {
                        self.photoPermissionStatus = "Limited Access"
                    } else {
                        self.photoPermissionStatus = "No Access"
                    }
                }
            }
        @unknown default:
            self.photoPermissionStatus = "Unknown Status"
        }
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}
