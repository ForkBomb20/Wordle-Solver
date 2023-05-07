//
//  WordleDataModel.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/4/23.
//

import SwiftUI

class WordleDataModel: ObservableObject{
    @Published var guesses: [Guess] = []
    @Published var attempts = [Int](repeating: 0, count: 6)
    @Published var picking: Bool = false
    @Published var showOptions: Bool = false
    @Published var showHelp: Bool = false
    
    var plays = [String]()
    var top_words = [String]()
    var top_es = [Double]()
    var currentWord = ""
    var keyColors = [String: Color]()
    var rowIndex = 0
    var inPlay = false
    
    var gameStarted: Bool{
        !currentWord.isEmpty || rowIndex > 0
    }
    
    var disabledKeys: Bool{
        !inPlay || currentWord.count == 5
    }
    
    init()
    {
        newGame()
    }
    func newGame(){
        populateDefaults()
        currentWord = ""
        inPlay = true
    }
    
    func populateDefaults() {
        guesses = []
        for index in 0...5{
            guesses.append(Guess(index: index))
        }
        
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for char in letters {
            keyColors[String(char)] = .unused
        }
        plays = [String]()
        top_words = [String]()
        top_es = [Double]()
        rowIndex = 0
        picking = false
        showOptions = false
        attempts = [Int](repeating: 0, count: 6)
    }
    
    func addToCurrentWord(_ letter: String){
        currentWord += letter
        updateRow()
    }
    
    func enterWord() {
        picking = true
    }
    
    func removeLetterFromCurrentWord(){
        currentWord.removeLast()
        updateRow()
    }
    
    func updateRow(){
        let guessWord = currentWord.padding(toLength: 5, withPad: " ", startingAt: 0)
        guesses[rowIndex].word = guessWord
    }
    
    func information(_ p: Double) -> Double{
        return log2(1/p)
    }
    
    func probability(word: String, state: [Int], words: [String]) -> Double{
        let possible: [String] = reduceToPossible(word: word, state: state, words: words)
        return Double(possible.count) / Double(words.count)
    }
    
    func entropy(word: String, states: [[Int]], words: [String]) -> Double{
        var e: Double = 0
        for state in states{
            let px = probability(word: word, state: state, words: words)
            if px != 0{
                e += px * information(px)
            }
        }
        return e
    }
    
    func reduceToPossible(word: String, state: [Int], words: [String]) -> [String]{
        var valid_words: [String] = []
        for i in 0 ..< word.count{
            let char = word[word.index(word.startIndex, offsetBy: i)]
            let rule = state[i]
            let word_list = i == 0 ? words: valid_words
            var temp: [String] = []
            for w in word_list{
                if rule == 0{
                    var safe: Bool = true
                    var notSafePos = 0
                    for j in 0 ..< state.count{
                        if state[j] == 1{
                            if word[word.index(word.startIndex, offsetBy: j)] == char{
                                safe = false
                                notSafePos = j
                            }
                        }
                    }
                    if safe && !w.contains(char){
                        temp.append(w)
                    }
//                    if !safe{
//                        if w[w.index(w.startIndex, offsetBy: notSafePos)] != char{
//                            temp.append(w)
//                        }
//                    }
                }
                if rule == 1{
//                    var notSafePos = 0
//                    for j in 0 ..< state.count{
//                        if state[j] == 0{
//                            if word[word.index(word.startIndex, offsetBy: j)] == char{
//                                notSafePos = j
//                            }
//                        }
//                    }
//                    if w[w.index(w.startIndex, offsetBy: i)] != char && w[w.index(w.startIndex, offsetBy: notSafePos)] != char && w.contains(char){
//                        temp.append(w)
//                    }
                    if w[w.index(w.startIndex, offsetBy: i)] != char && w.contains(char){
                        temp.append(w)
                    }
                }
                if rule == 2{
                    if w[w.index(w.startIndex, offsetBy: i)] == char{
                        temp.append(w)
                    }
                }
            }
            valid_words = []
            for k in 0..<temp.count{
                valid_words.append(temp[k])
            }
        }
        return valid_words
    }
        
}
