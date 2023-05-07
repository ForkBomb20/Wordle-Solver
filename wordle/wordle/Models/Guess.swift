//
//  Guess.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/4/23.
//

import SwiftUI

struct Guess{
    let index: Int
    var word = "     "
    var bgColors = [Color](repeating: .systemBackground, count: 5)
    var guessLetters: [String] {
        word.map{String($0)}
    }
    
}
