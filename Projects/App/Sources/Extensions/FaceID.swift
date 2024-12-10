//
//  FaceID.swift
//  NewForSwiftUI
//
//  Created by Benji Loya on 08/03/2023.
//

import SwiftUI
import LocalAuthentication

struct FaceID: View {
    
    @State var islocked = false
    @State var text = "LOCKED"
    
    var body: some View {
        VStack{
            Text(text)
                .bold()
                .padding()
            
            Button("Authenticate") {
                authenticate()
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    //self.islocked = true
                    text = "UNLOCKED"
                } else {
                    //error
                    text = "There was a problem"
                }
            }
        } else {
            //no biometrics
            text = "Phone does not have Biometrics"
        }
    }
}

struct FaceID_Previews: PreviewProvider {
    static var previews: some View {
        FaceID()
    }
}
