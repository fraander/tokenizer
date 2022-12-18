//
//  TokenizeApp.swift
//  Tokenize
//
//  Created by Frank Anderson on 12/18/22.
//

import SwiftUI

@main
struct TokenizeApp: App {
    var body: some Scene {
        WindowGroup {
            UsageExample()
                .navigationTitle("Example Usage")
                .frame(idealWidth: 400)
        }
    }
}
