//
//  WelcomeView.swift
//  MyResort
//
//  Created by Mantosh Kumar on 24/11/24.
//

import SwiftUI


struct WelcomeView: View {
    
    var body: some View {
        
        VStack {
            Text("Welcome to MyResort")
                .font(.largeTitle)
                .padding()
            
            Text("Please select a resort from the left side list")
        }
    }
}

#Preview {
    WelcomeView()
}
