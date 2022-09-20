//
//  ContentView.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import SwiftUI

struct ContentView: View {
    
    var client = XPCClient()
    
    var body: some View {
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
        } label: {
            Text("Export")
        }
        
        Button {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/Library/LaunchDaemons")
        } label: {
            Text("Open LaunchDaemons")
        }
        
        Button {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/Library/PrivilegedHelperTools")
        } label: {
            Text("Open PrivilegedHelperTools")
        }
        
        Button {
            NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "/private/etc/")
        } label: {
            Text("Open SMJobBlessDemo.txt")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
