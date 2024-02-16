//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by FANG-LIN HE on 03.02.2024.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State var backupScrums: [DailyScrum] = []
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewScrum = false
    @State private var isEditing = false
    let saveAction: ()->Void

    private var doneDeletingScrumsButton: some View {
        Button(action: {
            isEditing = false
            backupScrums = []
        }) {
            Text("Done")
        }
        .accessibilityLabel("Done Deleting")
    }
    
    private var editScrumsButton: some View {
        Button(action: {
            isEditing = true
            backupScrums = scrums
        }) {
            Text("Edit")
        }
        .accessibilityLabel("Move or delete scrums")
        .disabled(scrums.isEmpty)
    }
    
    private var cancelEditingScrumsButton: some View {
        Button(action: {
            isEditing = false
            scrums = backupScrums
            backupScrums = []
        }) {
            Text("Cancel")
        }
        .accessibilityLabel("Cancel moving or deleting Scrums")
    }
    
    private var addNewScrumButton: some View {
        Button(action: {
            isPresentingNewScrum = true
            isEditing = false
        }) {
            Image(systemName: "plus")
        }
        .accessibilityLabel("New Scrum")
    }
    
    var body: some View {
        NavigationStack {
            if isEditing {
                List {
                    ForEach(scrums.indices, id: \.self) { scrumIndex in
                        let scrum = scrums[scrumIndex]
                        CardView(scrum: scrum)
                            .listRowBackground(scrum.theme.mainColor)
                            .moveDisabled(false)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    scrums.remove(at: scrumIndex)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .accessibilityLabel("Delete scrum \(scrum.title)")
                            }
                    }
                    .onMove { indexSet, index in
                        scrums.move(fromOffsets: indexSet, toOffset: index)
                    }
                }
                .navigationTitle("Move/Delete Scrums")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        doneDeletingScrumsButton
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        cancelEditingScrumsButton
                    }
                }
            } else {  // not editing
                List{
                    ForEach($scrums) { $scrum in
                        NavigationLink(destination: DetailView(scrum: $scrum)) {
                            CardView(scrum: scrum)
                        }
                        .listRowBackground(scrum.theme.mainColor)
                    }
                }
                .navigationTitle("Daily Scrums")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        editScrumsButton
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        addNewScrumButton
                    }
                }
            }
        }
        .sheet(isPresented: $isPresentingNewScrum) {
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrum)
        }
        .onChange(of: scenePhase) { scene in
            if scene == .inactive { saveAction() }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
}
