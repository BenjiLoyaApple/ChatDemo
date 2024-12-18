//
//  Photos.swift
//  ChatDemo
//
//  Created by Benji Loya on 10.12.2024.
//

import SwiftUI
import Photos
import Components

struct PhotoPermissionView: View {
    @StateObject private var permissionManager = PhotoPermissionManager()
    @Environment(\.router) var router
    
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
                
                if permissionManager.photoPermissionStatus == "Full Access" ||
                   permissionManager.photoPermissionStatus == "Limited Access" {
                    
                    Divider()
                        .opacity(0.5)
                        .padding(.top)
                    
                    Button {
                        permissionManager.openAppSettings()
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
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
    }
    
    private var title: AttributedString {
        let string = """
        Allow access to your photo library to select, view, and manage images directly from your device. This permission ensures seamless integration with your gallery while keeping your data private and secure. 
        \nCurrent Status: \(permissionManager.photoPermissionStatus)
        """
        
        var attString = AttributedString(stringLiteral: string)
        
        if let range = attString.range(of: "\(permissionManager.photoPermissionStatus)") {
            attString[range].foregroundColor = Color.theme.darkWhite
            attString[range].font = .footnote.bold()
        }
        
        return attString
    }
}

#Preview {
    PhotoPermissionView()
}
