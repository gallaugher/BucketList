//  ContentView.swift
//  BucketList
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import SwiftUI
import SwiftData

struct BucketListView: View {
    enum Segments: String, CaseIterable {
        case all = "All"
        case completed = "Completed"
        case open = "Open"
    }
    
    var filteredGoals: [Goal] {
        switch selectedSegment {
        case .all:
            return goals
        case .completed:
            return goals.filter { $0.completed }
        case .open:
            return goals.filter { !$0.completed }
        }
    }
    
    @Query var goals: [Goal]
    @State private var sheetIsPresented = false
    @State private var selectedSegment: Segments = .all
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            
            Picker("", selection: $selectedSegment) {
                ForEach(Segments.allCases, id: \.self) { segment in
                    Text(segment.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            List(filteredGoals) { goal in
                NavigationLink {
                    DetailView(goal: goal)
                } label: {
                    HStack {
                        Image(systemName: goal.completed ? "checkmark.square" : "square")
                        Text(goal.title)
                    }
                    .font(.title2)
                }
                .swipeActions {
                    Button("", systemImage: "trash", role: .destructive) {
                        modelContext.delete(goal)
                        guard let _ = try? modelContext.save() else {
                            print("😡 ERROR: Save after .delete did not work.")
                            return
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Bucket List:")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", systemImage: "plus") {
                        sheetIsPresented.toggle()
                    }
                }
            }
        }
        .sheet(isPresented: $sheetIsPresented) {
            NavigationStack {
                DetailView(goal: Goal())
            }
        }
    }
}

#Preview {
    BucketListView()
        .modelContainer(Goal.preview)
}
