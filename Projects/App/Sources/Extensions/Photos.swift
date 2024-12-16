//
//  Photos.swift
//  ChatDemo
//
//  Created by Benji Loya on 10.12.2024.
//

import SwiftUI
import Photos
import Components

struct PhotosGalleryView: View {
    @Environment(\.router) var router
    @State private var photoPermissionStatus: String = "Checking..."
    
    var body: some View {
        VStack {
            HeaderComponent(backButtonPressed: { router.dismissScreen() }, buttonImageSource: .systemName("chevron.left")) {
                Spacer()
                
                Text("Photos Access")
                    .font(.subheadline.bold())
                    .offset(x: -20)
                    .padding(.vertical, 8)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text(title)
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                    .padding(.top, 4)
                
//                Button {
//                    checkPhotoLibraryPermission { status in
//                        photoPermissionStatus = status
//                    }
//                } label: {
//                    Text("Check or Request Access")
//                        .tint(.primary)
//                        .font(.subheadline)
//                        .fontWeight(.medium)
//                        .padding(.vertical, 10)
//                        .background(Color.black.opacity(0.001))
//                }
                
                if photoPermissionStatus == "Full Access" || photoPermissionStatus == "Limited Access" {
                    
                Divider()
                    .opacity(0.5)
                    .padding(.top)
                
                    Button {
                        openAppSettings()
                    } label: {
                        Text("Go to Settings to Change Access")
                            .tint(.primary.opacity(0.8))
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.vertical, 10)
                            .background(Color.black.opacity(0.001))
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
        }
        .onAppear {
            // Проверяем статус доступа при загрузке
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                checkPhotoLibraryPermission { status in
                    photoPermissionStatus = status
                }
            }
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
        
        
    }
    
    private var title: AttributedString {
        let string = "Allow access to your photo library to select, view, and manage images directly from your device. This permission ensures seamless integration with your gallery while keeping your data private and secure. \nCurrent Status: \(photoPermissionStatus)"
        
        var attString = AttributedString(stringLiteral: string)
        
        if let range = attString.range(of: "\(photoPermissionStatus)") {
            attString[range].foregroundColor = Color.theme.darkWhite
            attString[range].font = .footnote.bold()
        }
        
        return attString
    }
    
    func checkPhotoLibraryPermission(completion: @escaping (String) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion("Full Access") // Полный доступ
        case .denied, .restricted:
            completion("No Access") // Нет доступа
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized {
                        completion("Full Access") // Полный доступ
                    } else {
                        completion("No Access") // Нет доступа
                    }
                }
            }
        case .limited:
            completion("Limited Access") // Ограниченный доступ
        @unknown default:
            completion("Unknown Status") // Неизвестный статус
        }
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}

#Preview {
    PhotosGalleryView()
}
