//  DetailView.swift
//  BucketList
//  Created by John Gallaugher on 11/16/25.
//  YouTube.com/profgallaugher - gallaugher.bsky.social

import SwiftUI
import SwiftData

struct DetailView: View {
    @State var goal: Goal
    @State private var title = ""
    @State private var notes = ""
    @State private var completed = false
    @State private var completedOn = Date()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Goal:")
                .bold()
            TextField("goal", text: $title)
                .textFieldStyle(.roundedBorder)
            
            Text("Notes:")
                .bold()
            TextField("notes", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
            
            Toggle("Completed?", isOn: $completed)
                .bold()
                .padding(.bottom)
            
            if completed {
                DatePicker("Completed on:", selection: $completedOn, displayedComponents: .date)
                    .bold()
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .font(.title2)
        .onAppear {
            title = goal.title
            notes = goal.notes
            completed = goal.completed
            completedOn = goal.completedOn
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", systemImage: "checkmark") {
                    goal.title = title
                    goal.notes = notes
                    goal.completed = completed
                    goal.completedOn = completedOn
                    
                    modelContext.insert(goal)
                    guard let _ = try? modelContext.save() else {
                        print("😡 ERROR: Save on DetailView did not work.")
                        return
                    }
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(goal: Goal(title: "Fix Healthcare", notes: "Pretty hard, but will be awesome when done", completed: false, completedOn: Date()))
            .modelContainer(for: Goal.self, inMemory: true)
    }
}
