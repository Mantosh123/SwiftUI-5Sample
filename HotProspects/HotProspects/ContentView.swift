//
//  ContentView.swift
//  HotProspects
//
//  Created by Mantosh Kumar on 03/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            ProspectView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            ProspectView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MeView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
