//
//  ContentView.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import SwiftUI

struct Plist {
    let url: URL
    var contents: String? {
        do {
            
            if !FileManager.default.fileExists(atPath: url.path) {
                return "(not found)"
            }
            
            guard let plistContent = try NSDictionary(contentsOf: url, error: ()) as? Dictionary<String, Any> else {
                return nil
            }
            return (plistContent as NSDictionary).description
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

struct ContentView: View {
    
    var client = XPCClient()
    @State private var launchDaemonsContents = ""
    private let launchDaemons = Plist(url: URL(fileURLWithPath: "/Library/LaunchDaemons/com.ikeh1024.SMJobBlessDemo.installer.plist"))
        
    @State private var existsPrivilegedHelperTool = false
    
    var body: some View {
        
        ScrollView {
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
            } label: {
                Text("Update status")
            }
            
            Divider()
            
            Button {
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/Library/LaunchDaemons")
            } label: {
                Text("Open LaunchDaemons")
            }
            launchDaemonsContentsView()
                .padding()
            
            Divider()
            
            Button {
                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/Library/PrivilegedHelperTools")
            } label: {
                Text("Open PrivilegedHelperTools")
            }
            privilegedHelperToolView()
                .padding()
        }
        .onAppear() {
            updateStatus()
        }
    }
    
    private func updateStatus() {
        launchDaemonsContents = launchDaemons.contents ?? ""
        
        // check
        let privilegedHelperToolUrl = URL(fileURLWithPath: "/Library/PrivilegedHelperTools/com.ikeh1024.SMJobBlessDemo.installer")
        existsPrivilegedHelperTool = FileManager.default.fileExists(atPath: privilegedHelperToolUrl.path)
    }
    
    @ViewBuilder
    private func launchDaemonsContentsView() -> some View {
        VStack(alignment: .leading) {
            Text("【\(launchDaemons.url.absoluteString)】")
            Text(launchDaemonsContents)
                .fixedSize(horizontal: true, vertical: true)
        }
        .textSelection(.enabled)
        .padding()
        .background(.background)
    }
    
    @ViewBuilder
    private func privilegedHelperToolView() -> some View {
        Text("/Library/PrivilegedHelperTools: \(existsPrivilegedHelperTool ? "exist" : "not found")")
            .textSelection(.enabled)
            .padding()
            .background(.background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
