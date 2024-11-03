//
//  ProspectView.swift
//  HotProspects
//
//  Created by Mantosh Kumar on 03/11/24.
//

import SwiftUI

struct ProspectView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
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
            Text("Hello")
                .navigationTitle(title)
        }
    }
    
}

#Preview {
    ProspectView(filter: .none)
}
