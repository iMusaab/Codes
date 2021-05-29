//
//  CodesApp.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import SwiftUI
import Firebase

@main
struct CodesApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView().environment(\.layoutDirection, .rightToLeft)
        }
    }
}
