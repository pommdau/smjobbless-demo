//
//  XPCServer.swift
//  com.ikeh1024.SMJobBlessDemo.installer
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import Foundation

class XPCServer: NSObject {
    
    internal static let shared = XPCServer()
    
    private var listener: NSXPCListener?
    
    internal func start() {
        listener = NSXPCListener(machServiceName: Constant.helperMachLabel)
        listener?.delegate = self
        listener?.resume()
    }
    
    private func connetionInterruptionHandler() {
        NSLog("[SMJBS]: \(#function)")
    }
    
    private func connectionInvalidationHandler() {
        NSLog("[SMJBS]: \(#function)")
    }
    
    private func isValidClient(forConnection connection: NSXPCConnection) -> Bool {
        
        var token = connection.auditToken;
        let tokenData = Data(bytes: &token, count: MemoryLayout.size(ofValue:token))
        let attributes = [kSecGuestAttributeAudit : tokenData]
        
        // Check which flags you need
        let flags: SecCSFlags = []
        var code: SecCode? = nil
        var status = SecCodeCopyGuestWithAttributes(nil, attributes as CFDictionary, flags, &code)
        
        if status != errSecSuccess {
            return false
        }
        
        guard let dynamicCode = code else {
            return false
        }
        // in this sample we duplicate the requirements from the Info.plist for simplicity
        // in a commercial application you could want to put the requirements in one place, for example in Active Compilation Conditions (Swift), or in preprocessor definitions (C, Objective-C)
        let entitlements = "identifier \"com.ikeh1024.SMJobBlessDemo.uiapplication\" and anchor apple generic and certificate leaf[subject.CN] = \"Apple Development: HIROKI IKEUCHI (7B3ZX97MAS)\""
        var requirement: SecRequirement?
        
        status = SecRequirementCreateWithString(entitlements as CFString, flags, &requirement)
        
        if status != errSecSuccess {
            return false
        }
        
        status = SecCodeCheckValidity(dynamicCode, flags, requirement)
        
        return status == errSecSuccess
    }
}

extension XPCServer: NSXPCListenerDelegate {
    
    // Client can establish XPC connection to the Privideged Helper
    func listener(_ listener: NSXPCListener, shouldAcceptNewConnection newConnection: NSXPCConnection) -> Bool {
        NSLog("[SMJBS]: \(#function)")
        
        if (!isValidClient(forConnection: newConnection)) {
            NSLog("[SMJBS]: Client is not valid")
            return false
        }
        
        NSLog("[SMJBS]: Client is valid")
        
        let installer = InstallerImpl()
        
        newConnection.exportedInterface = NSXPCInterface(with: Helper.self)
        newConnection.exportedObject = installer
        newConnection.remoteObjectInterface = NSXPCInterface(with: InstallationClient.self)
        newConnection.interruptionHandler = connetionInterruptionHandler
        newConnection.invalidationHandler = connectionInvalidationHandler
        newConnection.resume()
        
        installer.client = newConnection.remoteObjectProxy as? InstallationClient
        
        return true
    }
}

