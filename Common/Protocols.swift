//
//  Protocols.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import Foundation

@objc protocol Installer {
    func install()
    func uninstall()
    func exportFile(contents: String)
}

@objc public protocol InstallationClient {
    func installationDidReachProgress(_ progress: Double, description: String?)
}

