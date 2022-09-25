//
//  Util.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import SecurityFoundation
import ServiceManagement

struct Util {
    
    static func askAuthorization() -> AuthorizationRef? {
        
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
    static func blessHelper(label: String, authorization: AuthorizationRef) -> Bool {
        
        var error: Unmanaged<CFError>?
        // Show `Install Helper` dialog...
        let blessStatus = SMJobBless(kSMDomainSystemLaunchd,
                                     label as CFString,
                                     authorization,
                                     &error)        
        if !blessStatus {
            NSLog("[SMJBS]: Helper bless failed with error \(error!.takeUnretainedValue())")
        }
        
        return blessStatus
    }
    
    @discardableResult
    static func unblessHelper(label: String, authorization: AuthorizationRef) -> Bool {
        
        var error: Unmanaged<CFError>?
        // Show `Install Helper` dialog...
        let unblessStatus = SMJobRemove(kSMDomainSystemLaunchd,
                                        label as CFString,
                                        authorization,
                                        true,
                                        &error)
        
        if !unblessStatus {
            NSLog("[SMJBS]: Helper unbless failed with error \(error!.takeUnretainedValue())")
        }
        
        return unblessStatus
    }
}

