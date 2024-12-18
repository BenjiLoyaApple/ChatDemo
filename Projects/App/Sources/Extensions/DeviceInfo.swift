//
//  DeviceInfo.swift
//  ChatDemo
//
//  Created by Benji Loya on 18.12.2024.
//

import SwiftUI
import Foundation
import Components

struct DeviceInfo {
    static func deviceDetails() -> [String: String] {
        var details: [String: String] = [:]
        
        // UIDevice данные
        let device = UIDevice.current
        details["Device Name"] = device.name // "John's iPhone"
        details["System Version"] = device.systemVersion // "17.2"
        
        // Точная модель
        details["Device Model"] = deviceModel()
        return details
    }
    
    static func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let identifier = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        return mapToDeviceName(identifier: identifier)
    }
    
    private static func mapToDeviceName(identifier: String) -> String {
        // Словарь идентификаторов устройств
        let deviceMap: [String: String] = [
            // iPhone 14 Series
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            
            // iPhone 13 Series
            "iPhone14,2": "iPhone 13 Pro",
            "iPhone14,3": "iPhone 13 Pro Max",
            "iPhone14,4": "iPhone 13 Mini",
            "iPhone14,5": "iPhone 13",
            
            // iPhone 12 Series
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,1": "iPhone 12 Mini",
            "iPhone13,4": "iPhone 12 Pro Max",
            
            // iPhone 11 Series
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max"
        ]
        
        return deviceMap[identifier] ?? "Unknown iPhone (\(identifier))"
    }
}

struct DeviceInfoView: View {
    @Environment(\.router) var router
    @State private var deviceDetails: [String: String] = [:]
    
    var body: some View {
        VStack {
            HeaderComponent(backButtonPressed: { router.dismissScreen() },buttonImageSource: .systemName("chevron.left")) {
                
                Spacer(minLength: 0)
                
                Text("Device info")
                    .font(.subheadline.bold())
                    .offset(x: -20)
                    .padding(.vertical, 8)
                
                Spacer(minLength: 0)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Your iPhone model is detected below. Knowing your device model helps optimize app performance and ensure compatibility with your hardware.")
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                    .padding(.top, 4)
                
                           ForEach(deviceDetails.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                               HStack {
                                   Text("\(key):")
                                       .foregroundStyle(.gray)
                                       .frame(width: 180, alignment: .leading)
                                   
                                   Spacer()
                                   
                                   Text(value)
                                       .fontWeight(.semibold)
                               }
                           }
                       }
                       .font(.footnote)
                       .frame(maxWidth: .infinity, alignment: .leading)
                       .padding(.horizontal)
            
            Spacer(minLength: 0)
            
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
        .onAppear {
          //  deviceModel = DeviceInfo.deviceModel()
            deviceDetails = DeviceInfo.deviceDetails()
        }
    }
}

#Preview {
    DeviceInfoView()
}
