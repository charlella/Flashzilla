//
//  CardView.swift
//  Flashzilla
//
//  Created by charlene hoareau on 12/04/2024.
//

import SwiftUI

struct CardView: View {
    @State private var isShowingAnswer = false

    let card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
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
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .frame(width: 450, height: 250)
    }
}


#Preview {
    CardView(card: .example)
}
