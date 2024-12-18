//
//  ContentView.swift
//  CardGame
//
//  Created by Mantosh Kumar on 11/11/24.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 6)
    }
}

struct ContentView: View {
    
    @State private var cards = [Card]()
    @State private var  timeRemaning = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Timer: \(timeRemaning)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(.capsule)
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                removeCard(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaning > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCard)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle").tint(.white)
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                            .padding()
                    }
                }
                Spacer()
            }
            .onReceive(timer) { timer in
                guard isActive else { return }
                
                if timeRemaning > 0 {
                    timeRemaning -= 1
                }
            }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    if cards.isEmpty {
                        isActive = true
                    }
                } else {
                    isActive = false
                }
            }
            .sheet(isPresented: $showingEditScreen, onDismiss: resetCard, content: AddCard.init)
            .onAppear(perform: resetCard)
        }
        
    }
    
    func removeCard(at index: Int) {
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCard() {
        timeRemaning = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
}

#Preview {
    ContentView()
}
