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
                Bless.blessHelper()
            } label: {
                Text("Install Helper...")
            }
            
            Button {
                Bless.unblessHelper()
            } label: {
                Text("Uninstall Helper...")
            }
            
            Button {
                
                client.exportFile(contents: "hogehoge")
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
                TableColumn("Path") { file in
                    Text(file.url.path)
                        .padding(.vertical, 8)
                }
                TableColumn("") { file in
                    if file.exists {
                        Button {
                            file.showInFinder()
                        } label: {
                            Text("Show in Finder")
                        }
                        .padding(.vertical, 8)
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
