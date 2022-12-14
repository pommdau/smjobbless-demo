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
        
        VStack(alignment: .leading) {
            actionButtons()
            filesTable()
        }
        .padding()
        .onAppear() {
            updateStatus()
        }
    }
    
    // MARK: - Helpers
        
    private func updateStatus() {
        files = files.map({ file in
            File(url: file.url)
        })
    }
}

// MARK: - ViewBuilder

extension ContentView {
    
    @ViewBuilder
    private func actionButtons() -> some View {
        HStack {
            Button {
                Bless.blessHelper()
                updateStatus()
            } label: {
                Text("Install Helper...")
            }
            
            Button {
                client.removeSMJobBlessFiles()
                Bless.unblessHelper()
                updateStatus()
            } label: {
                Text("Uninstall Helper...")
            }
            
            Button {
                client.exportFile(contents: "hogehoge")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    updateStatus()
                }
            } label: {
                Text("Export File")
            }
            
            Button {
                updateStatus()
            } label: {
                Text("Update status")
            }
        }
    }
    
    @ViewBuilder
    private func filesTable() -> some View {
        Table(files, columns: {
            TableColumn("Path") { file in
                Text(file.url.path)
                    .padding(.vertical, 16)
            }
            TableColumn("") { file in
                if file.exists {
                    Button {
                        file.showInFinder()
                    } label: {
                        Text("Show in Finder")
                    }
                    .padding(.vertical, 16)
                } else {
                    Text("")
                        .padding(.vertical, 16)
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
