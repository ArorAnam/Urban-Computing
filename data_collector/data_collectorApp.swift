//
//  data_collectorApp.swift
//  data_collector
//
//  Created by Naman Arora on 16/10/2023.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseFirestore
import FirebaseAuth

@main
struct data_collectorApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}




