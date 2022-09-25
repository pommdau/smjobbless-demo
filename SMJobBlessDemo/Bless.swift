//
//  Bless.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import SecurityFoundation
import ServiceManagement

struct Bless {
    
    static private func askAuthorization() -> AuthorizationRef? {
        
        var auth: AuthorizationRef?
        // Obtain Authorization object
        let status: OSStatus = AuthorizationCreate(nil, nil, [], &auth)
        if status != errAuthorizationSuccess {
            NSLog("[SMJBS]: Authorization failed with status code \(status)")
            return nil
        }
        
        return auth
    }
    
    @discardableResult
    static func blessHelper() -> Bool {
        
        guard let auth = Bless.askAuthorization() else {
            fatalError("Authorization not acquired.")
        }
        
        var error: Unmanaged<CFError>?
        // Show `Install Helper` dialog...
        let blessStatus = SMJobBless(kSMDomainSystemLaunchd,
                                     Constant.helperMachLabel as CFString,
                                     auth,
                                     &error)        
        if !blessStatus {
            NSLog("[SMJBS]: Helper bless failed with error \(error!.takeUnretainedValue())")
        }
        
        return blessStatus
    }
    
    @discardableResult
    static func unblessHelper() -> Bool {
        
        guard let auth = Bless.askAuthorization() else {
            fatalError("Authorization not acquired.")
        }
        
        var error: Unmanaged<CFError>?
        // Show `Install Helper` dialog...
        let unblessStatus = SMJobRemove(kSMDomainSystemLaunchd,
                                        Constant.helperMachLabel as CFString,
                                        auth,
                                        true,
                                        &error)
        
        if !unblessStatus {
            NSLog("[SMJBS]: Helper unbless failed with error \(error!.takeUnretainedValue())")
        }
        
        return unblessStatus
    }
}

