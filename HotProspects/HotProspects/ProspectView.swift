//
//  ProspectView.swift
//  HotProspects
//
//  Created by Mantosh Kumar on 03/11/24.
//

import SwiftUI
import SwiftData
import CodeScanner

struct ProspectView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospacts: [Prospect]
    
    @State private var isShowingScanner = false
    @State private var selectedProspect = Set<Prospect>()
    
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
            List(prospacts) { prospact in
                VStack(alignment: .leading) {
                    Text(prospact.name)
                        .font(.headline)
                    Text(prospact.emailAddress)
                        .font(.subheadline)
                }
                .swipeActions {
                    
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(prospact)
                    }
                    
                    if prospact.isConnected {
                        Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark") {
                            prospact.isConnected.toggle()
                        }.tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospact.isConnected.toggle()
                        }
                        .tint(.green)
                    }
                }
                .tag(prospact)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScanner = true
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                if selectedProspect.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selection", action:  delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes:[.qr], simulatedData: "mantosh", completion: handleScan)
            }
        }
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showconected = filter == .contacted
            
            _prospacts = Query(filter: #Predicate{ $0.isConnected == showconected
                
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isConnected: true )
            
            modelContext.insert(person)
            //modelContext.save()
            
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func delete() {
        for prospact in selectedProspect {
            modelContext.delete(prospact)
        }
    }
}

#Preview {
    ProspectView(filter: .none)
        .modelContainer(for: Prospect.self)
}
