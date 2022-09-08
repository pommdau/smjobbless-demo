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
            Util.blessHelper(label: Constant.helperMachLabel, authorization: auth)
            client.start()
        } label: {
            Text("Action!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
