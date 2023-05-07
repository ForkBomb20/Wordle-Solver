//
//  ContentView.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/4/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var dm: WordleDataModel
    
    var body: some View {
        if !dm.picking && !dm.showHelp{
            ZStack{
                NavigationView{
                    VStack{
                        Spacer()
                        VStack(spacing: 3){
                            GuessView(guess: $dm.guesses[0])
                            GuessView(guess: $dm.guesses[1])
                            GuessView(guess: $dm.guesses[2])
                            GuessView(guess: $dm.guesses[3])
                            GuessView(guess: $dm.guesses[4])
                            GuessView(guess: $dm.guesses[5])
                        }
                        .frame(width: Global.boardWidth, height: 6 * Global.boardWidth / 5)
                        Spacer()
                        Keyboard()
                            .scaleEffect(Global.keyboardScale)
                            .padding(.top)
                        Spacer()
                    }
                    .blur(radius: (dm.picking ? 2 : 0))
                    
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .navigationBarLeading){
                            Button{
                                dm.showHelp = true
                            }label: {
                                Image(systemName: "questionmark.circle")
                            }.foregroundColor(.secondary)
                                .blur(radius: (dm.picking ? 2 : 0))
                        }
                        ToolbarItem(placement: .principal){
                            Text("WORDLE").font(.largeTitle).fontWeight(.heavy).foregroundColor(.primary).blur(radius: (dm.picking ? 2 : 0))
                        }
                        ToolbarItem(placement: .navigationBarTrailing){
                            HStack{
                                Button{
                                    
                                }label:{
                                    Image(systemName: "chart.bar")
                                }.foregroundColor(.secondary).blur(radius: (dm.picking ? 2 : 0))
                                Button{
                                    dm.newGame()
                                }label: {
                                    Image(systemName: "arrow.counterclockwise")
                                }.foregroundColor(.secondary).blur(radius: (dm.picking ? 2 : 0))
                            }
                        }
                    }
                }
                .navigationViewStyle(.stack)
                if dm.showOptions{
                    TopWords().offset(y:-40)
                }
            }
        }
        else{
            if dm.picking{
                ColorPickerView()
            }
            if dm.showHelp{
                HelpView()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(WordleDataModel())
    }
}
