//
//  ProjectScoresApp.swift
//  ProjectScores
//
//  Created by George Kortsaridis on 29/10/2024.
//

import SwiftUI

@main
struct ProjectScoresApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
