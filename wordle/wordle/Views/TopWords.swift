//
//  TopWords.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/6/23.
//

import SwiftUI

struct TopWords: View {
    @EnvironmentObject var dm: WordleDataModel
    var body: some View {
        VStack{
            if dm.top_words.count > 0{
                let count = dm.top_words.count >= 10 ? 10 : dm.top_words.count
                Text("Options").font(.title).bold().offset(y:-10)
                ForEach((0..<count)) { i in
                    Text("\(dm.top_words[i]): \(dm.top_es[i])")
                }
                Button{
                    dm.showOptions = false
                    
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15).frame(width: 100, height: 50).foregroundColor(.white)
                        Text("OK").foregroundColor(.black)
                    }
                }
            }
            else{
                let count = dm.top_words.count >= 10 ? 10 : dm.top_words.count
                Text("No words match\nthese rules!").font(.title2).bold().offset(y:-10)
                Button{
                    dm.showOptions = false
                    
                }label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15).frame(width: 100, height: 50).foregroundColor(.white)
                        Text("OK").foregroundColor(.black)
                    }
                }
            }
        }.background{
            RoundedRectangle(cornerRadius: 25).frame(width: 200, height: 400).foregroundColor(Color("lightgray")).blur(radius: 1)
        }
    }
}

struct TopWords_Previews: PreviewProvider {
    static var previews: some View {
        TopWords()
            .environmentObject(WordleDataModel())
    }
}
