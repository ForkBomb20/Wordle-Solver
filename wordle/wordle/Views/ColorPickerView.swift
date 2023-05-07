//
//  ColorPickerView.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/5/23.
//

import SwiftUI

struct ColorPickerView: View {
    @EnvironmentObject var dm: WordleDataModel
    @State private var color1 = Color.unused
    @State private var color2 = Color.unused
    @State private var color3 = Color.unused
    @State private var color4 = Color.unused
    @State private var color5 = Color.unused
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Letter Colors")){
                    Picker("First Letter", selection: $color1){
                        Text("Correct").tag(Color.correct)
                        Text("Misplaced").tag(Color.misplaced)
                        Text("Unused").tag(Color.unused)
                    }
                    Picker("Second Letter", selection: $color2){
                        Text("Correct").tag(Color.correct)
                        Text("Misplaced").tag(Color.misplaced)
                        Text("Unused").tag(Color.unused)
                    }
                    Picker("Third Letter", selection: $color3){
                        Text("Correct").tag(Color.correct)
                        Text("Misplaced").tag(Color.misplaced)
                        Text("Unused").tag(Color.unused)
                    }
                    Picker("Fourth Letter", selection: $color4){
                        Text("Correct").tag(Color.correct)
                        Text("Misplaced").tag(Color.misplaced)
                        Text("Unused").tag(Color.unused)
                    }
                    Picker("Fifth Letter", selection: $color5){
                        Text("Correct").tag(Color.correct)
                        Text("Misplaced").tag(Color.misplaced)
                        Text("Unused").tag(Color.unused)
                    }
                }
            }
            
            Button{
                if dm.picking == true{
                    dm.guesses[dm.rowIndex].bgColors = [color1, color2, color3, color4, color5]
                    
                    let word = dm.currentWord.lowercased()
                    var state: [Int] = []
                    for color in dm.guesses[dm.rowIndex].bgColors{
                        switch color{
                            case Color.unused:
                                state.append(0)
                            case Color.misplaced:
                                state.append(1)
                            default:
                                state.append(2)
                        }
                            
                    }
                    
                    dm.plays = dm.reduceToPossible(word: word, state: state, words: dm.rowIndex == 0 ? Global.wordleWords: dm.plays)
                

                    var temp: [String: Double] = [:]
                    for word in dm.plays{
                        temp[word] = dm.entropy(word: word, states: Global.states, words: dm.plays)
                    }

                    let sorted = temp.sorted{ $0.1 > $1.1 }
                    
                    dm.top_words = [String]()
                    dm.top_es = [Double]()
                    for (key, value) in sorted{
                        dm.top_words.append(key)
                        dm.top_es.append(value)
                    }
                    
                    dm.picking = false
                    dm.currentWord = ""
                    dm.rowIndex += 1
                    
                    dm.showOptions = true
                    
                }
                else{
                    dm.picking = false
                    dm.showOptions = true
                }
            }label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 50)
                    Text("Submit").foregroundColor(.white)
                }.offset(y:10)
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
            .environmentObject(WordleDataModel())
    }
}
