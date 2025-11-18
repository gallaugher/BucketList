//  BucketListApp.swift
//  BucketList
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import SwiftUI
import SwiftData

@main
struct BucketListApp: App {
    var body: some Scene {
        WindowGroup {
            BucketListView()
                .modelContainer(for: Goal.self)
        }
    }
    
    // Will allow us to find where our simulator datea is saved:
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
