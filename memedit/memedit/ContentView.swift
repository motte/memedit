//
//  ContentView.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        ZStack {
            FeedView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
