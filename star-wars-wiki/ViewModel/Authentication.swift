//
//  Authentication.swift
//  star-wars-wiki
//
//  Created by Alara Özdenler on 07.05.24.
//

import Foundation
import LocalAuthentication
import os

@Observable class Authentication {
    var isUnlocked = false
    let logger = Logger()
    
    func authenticate() async {
        let context = LAContext()
        var error: NSError?
        
        while !isUnlocked {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "We need to unlock the app"
                do {
                    self.isUnlocked = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason)
                }
                catch {
                    logger.warning("Error with authentication: \(error)")
                }
            }
        }
    }
}
