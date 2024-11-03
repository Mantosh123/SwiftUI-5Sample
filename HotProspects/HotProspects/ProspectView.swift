//
//  ProspectView.swift
//  HotProspects
//
//  Created by Mantosh Kumar on 03/11/24.
//

import SwiftUI
import SwiftData

struct ProspectView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospacts: [Prospect]
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var body: some View {
        NavigationStack {
            Text("People:\(prospacts.count)")
                .navigationTitle(title)
                .toolbar {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        let prospect = Prospect(name: "mantosh", emailAddress: "mantosh.123", isConnected: true)
                        modelContext.insert(prospect)
                    }
                }
        }
    }
    
}

#Preview {
    ProspectView(filter: .none)
        .modelContainer(for: Prospect.self)
}
