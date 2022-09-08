//
//  CommonFunction.swift
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

import Foundation

struct CommonFunction {
    static func createFileToLibrary() {
        do {
            try "hogehoge".write(toFile: "private/etc/SMJobBlessDemo.txt",
                                 atomically: true,
                                 encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}

