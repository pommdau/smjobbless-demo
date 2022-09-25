//
//  XPCClient.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import Foundation

class XPCClient {
    
    private var connection: NSXPCConnection?
    
    private var helper: Helper? {
        return connection?.remoteObjectProxy as? Helper
    }
    
    // MARK: - XPCConnection
    
    private func startConnection() {
        connection = NSXPCConnection(machServiceName: Constant.helperMachLabel,
                                         options: .privileged)
        connection?.exportedInterface = NSXPCInterface(with: InstallationClient.self)
        connection?.exportedObject = InstallationClientImpl()
        connection?.remoteObjectInterface = NSXPCInterface(with: Helper.self)
        connection?.invalidationHandler = connectionInvalidationHandler
        connection?.interruptionHandler = connetionInterruptionHandler
        connection?.resume()
    }
    
    private func stopConnection() {
        connection?.invalidate()
    }
    
    // MARK: - Helper Methods
    
    func exportFile(contents: String) {
        startConnection()
        guard let helper = helper else {
            return
        }
        helper.exportFile(contents: contents)
        stopConnection()
    }
    
    func removeSMJobBlessFiles() {
        startConnection()
        guard let helper = helper else {
            return
        }
        helper.uninstall()
        stopConnection()
    }
    
    private func connetionInterruptionHandler() {
        NSLog("[XPCTEST] \(type(of: self)): connection has been interrupted XPCTEST")
    }
    
    private func connectionInvalidationHandler() {
        NSLog("[XPCTEST] \(type(of: self)): connection has been invalidated XPCTEST")
    }
}

class InstallationClientImpl: NSObject, InstallationClient {
    
    func installationDidReachProgress(_ progress: Double, description: String?) {
        NSLog("[XPCTEST]: \(#function)")
    }
}

