//
//  memeditApp.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI

@main
struct memeditApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
