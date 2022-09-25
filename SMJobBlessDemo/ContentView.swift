//
//  ContentView.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import SwiftUI

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
//                client.start()
            } label: {
                Text("Install Helper...")
            }
            
            Button {
//                client.start()
//                guard let helper = client.connection?.remoteObjectProxy as? Installer else {
//                    return
//                }
//                helper.uninstall()
                guard let auth = Util.askAuthorization() else {
                    fatalError("Authorization not acquired.")
                }
                
//                Util.unblessHelper(label: Constant.helperMachLabel,
//                                   authorization: auth)
                client.stop()
            } label: {
                Text("Uninstall Helper...")
            }
            
            Button {
                client.start()
                guard let helper = client.connection?.remoteObjectProxy as? Installer else {
                    return
                }
                helper.exportFile(contents: "hogehoge")
                updateStatus()
            } label: {
                Text("Export File")
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
        
    private func updateStatus() {
        files = files.map({ file in
            File(url: file.url)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
