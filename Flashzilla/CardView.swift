//
//  CardView.swift
//  Flashzilla
//
//  Created by charlene hoareau on 12/04/2024.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    let card: Card
    var removal: (() -> Void)? = nil
    
    var body: some View {
        let fillColor = accessibilityDifferentiateWithoutColor
            ? Color.white.opacity(1 - Double(abs(offset.width / 50)))
            : Color.white.opacity(1 - Double(abs(offset.width / 50)))

        let backgroundFill = accessibilityDifferentiateWithoutColor
            ? nil
            : RoundedRectangle(cornerRadius: 25).fill(offset.width > 0 ? Color.green : Color.red)

        let shadowedRoundedRectangle = RoundedRectangle(cornerRadius: 25)
            .fill(fillColor)
            .background(backgroundFill)
            .shadow(radius: 10)

        let content = VStack {
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

        let accessibilityControls = accessibilityDifferentiateWithoutColor
            ? VStack {
                Spacer()

                HStack {
                    Image(systemName: "xmark.circle")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                    Spacer()
                    Image(systemName: "checkmark.circle")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                }
                .foregroundStyle(.white)
                .font(.largeTitle)
                .padding()
            }
            : nil

        return ZStack {
            shadowedRoundedRectangle
            content
        }
        .overlay(accessibilityControls)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(1 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
    }

}



#Preview {
    CardView(card: .example)
}
