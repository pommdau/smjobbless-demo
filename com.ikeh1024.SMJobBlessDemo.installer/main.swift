//
//  main.swift
//  com.ikeh1024.SMJobBlessDemo.installer
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import Foundation

NSLog("[SMJBS]: Privileged Helper has started")

XPCServer.shared.start()

CFRunLoopRun()

