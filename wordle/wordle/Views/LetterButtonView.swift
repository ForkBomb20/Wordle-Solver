//
//  LetterButtonView.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/4/23.
//

import SwiftUI

struct LetterButtonView: View {
    @EnvironmentObject var dm: WordleDataModel
    var letter: String
    var body: some View {
        Button{
            dm.addToCurrentWord(letter)
        }label: {
            Text(letter)
                .font(.system(size: 17))
                .frame(width: 35, height: 50)
                .background(dm.keyColors[letter]).cornerRadius(7)
                .foregroundColor(.primary)        }
    }
}

struct LetterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LetterButtonView(letter: "L")
            .environmentObject(WordleDataModel())
    }
}
