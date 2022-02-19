//
//  MusicAppJaredApp.swift
//  MusicAppJared
//
//  Created by Klaus Unruh on 16.02.22.
//

import SwiftUI
import Firebase

@main
struct MusicAppJaredApp: App {
    let data = OurData()
    
    init() {
        FirebaseApp.configure()
        data.loadAlbums()
    }
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
