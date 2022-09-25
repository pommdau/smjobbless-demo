//
//  File.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/25.
//

import AppKit

struct File: Identifiable {
    let id: UUID
    let url: URL
    var exists: Bool
    
    init(id: UUID = UUID(), url: URL) {
        self.id = id
        self.url = url
        self.exists = Self.exists(withUrl: url)
    }
    
    static func exists(withUrl url: URL) -> Bool {
       return FileManager.default.fileExists(atPath: url.path)
    }
    
    func showInFinder() {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
    
    mutating func updateStatus() {
        self.exists = Self.exists(withUrl: url)
    }
}

extension File {
    static let targetFiles: [File] = [
        File(url: URL(fileURLWithPath: "/Library/LaunchDaemons/com.ikeh1024.SMJobBlessDemo.installer.plist")),
        File(url: URL(fileURLWithPath: "/Library/PrivilegedHelperTools/com.ikeh1024.SMJobBlessDemo.installer")),
        File(url: URL(fileURLWithPath: "/private/etc/SMJobBlessDemo.txt"))
    ]
}
