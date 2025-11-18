//  Goal.swift
//  BucketList
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import Foundation
import SwiftData

@Model

class Goal {
    var title: String
    var notes: String
    var completed: Bool
    var completedOn = Date()
    
    init(title: String, notes: String, completed: Bool, completedOn: Date = Date()) {
        self.title = title
        self.notes = notes
        self.completed = completed
        self.completedOn = completedOn
    }
    
    convenience init() {
        self.init(title: "", notes: "", completed: false)
    }
}

extension Goal {
    
    static var preview: ModelContainer {
        let container = try! ModelContainer(for: Goal.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        let calendar = Calendar.current
        let scubaCertCompletedOn = calendar.date(from: DateComponents(year: 2023, month: 12, day: 25))!
        let greatWallHikeCompletedOn = calendar.date(from: DateComponents(year: 2018, month: 03, day: 01))!

        
        Task { @MainActor in
            // Create the actual MockData & insert it into container:
            container.mainContext.insert(Goal(title: "Dive the Great Barrier Reef", notes: "Need scuba certification first", completed: false, completedOn: Date()))
            container.mainContext.insert(Goal(title: "Become Scuba Certified", notes: "East Coast Divers is in Brookline, MA that can do this", completed: true, completedOn: scubaCertCompletedOn))
            container.mainContext.insert(Goal(title: "Hike the Great Wall", notes: "Maybe during study abroad", completed: true, completedOn: greatWallHikeCompletedOn))
            container.mainContext.insert(Goal(title: "Safari in Kenya", notes: "Try to schedule something during the Great Migration", completed: false, completedOn: Date()))
            container.mainContext.insert(Goal(title: "Hike Machu Picchu", notes: "Learning to surf in Lima might also be cool.", completed: false, completedOn: Date()))
        }
        
        return container
    }
}
