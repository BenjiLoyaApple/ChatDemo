//
//  FaceIDManager.swift
//  ChatDemo
//
//  Created by Benji Loya on 10.12.2024.
//

import SwiftUI
import LocalAuthentication

class FaceIDManager {
    static func authenticate(reason: String, completion: @escaping (Bool, String?) -> Void) {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        completion(true, nil)
                    } else {
                        completion(false, "Authentication failed. Please try again.")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false, "Biometrics not available on this device.")
            }
        }
    }
}
