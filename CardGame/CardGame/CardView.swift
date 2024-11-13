//
//  CardView.swift
//  CardGame
//
//  Created by Mantosh Kumar on 11/11/24.
//

import SwiftUI

struct CardView: View {
 
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white
                    .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                    
                )
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 200)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded{ _ in
                    if abs(offset.width) > 100 {
                        // remove
                        removal?()
                    } else {
                        offset = .zero
                    }
            }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

//#Preview {
//    CardView(card: Card.init(prompt: "test ", answer: "ok"), isShowingAnswer: true)
//}
