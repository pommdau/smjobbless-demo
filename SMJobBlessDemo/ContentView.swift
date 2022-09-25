//
//  ContentView.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import SwiftUI

struct File: Identifiable {
    let id = UUID()
    let url: URL
    var exists: Bool {
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    func showInFinder() {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
}

extension File {
    static let targetFiles: [File] = [
        File(url: URL(fileURLWithPath: "/Library/LaunchDaemons/com.ikeh1024.SMJobBlessDemo.installer.plist")),
        File(url: URL(fileURLWithPath: "/Library/PrivilegedHelperTools/com.ikeh1024.SMJobBlessDemo.installer")),
    ]
}

struct ContentView: View {
    
    private var client = XPCClient()
    @State private var files = File.targetFiles
            
    var body: some View {
        
        VStack {
            Button {
                guard let auth = Util.askAuthorization() else {
                    fatalError("Authorization not acquired.")
                }
                Util.blessHelper(label: Constant.helperMachLabel,
                                 authorization: auth)
                client.start()
            } label: {
                Text("Action!")
            }
            
            Button {
                guard let installer = client.connection?.remoteObjectProxy as? Installer else {
                    return
                }
                installer.updateHostsFile(contents: "")
                
                updateStatus()
            } label: {
                Text("Export")
            }
            
            Button {
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/private/etc/")
            } label: {
                Text("Open SMJobBlessDemo.txt")
            }
            
            Button {
                updateStatus()
                print(files)
                files.append(File(url: URL(fileURLWithPath: "hogeo")))
            } label: {
                Text("Update status")
            }
            
            Table(files, columns: {
                TableColumn("Path", value: \.url.path)
                TableColumn("") { file in
                    if file.exists {
                        Button {
                            file.showInFinder()
                        } label: {
                            Text("Show in Finder")
                        }
                        .padding()
                    }
                }
            })
            .padding()
        }

        
        .onAppear() {
            updateStatus()
        }
    }
    
    let fruits = ["りんご", "オレンジ", "バナナ"]
    
    private func updateStatus() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
