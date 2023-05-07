//
//  HelpView.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/7/23.
//

import SwiftUI

struct HelpView: View {
    @EnvironmentObject var dm: WordleDataModel
    var body: some View {
        VStack(spacing: 20){
            Text("How To Use").font(Font.custom("karnakpro-condensedblack", size: 36)).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("Input your words and choose the best plays.").font(.custom("georgia", size: 24)).frame(maxWidth: .infinity, alignment: .leading)
            VStack(spacing: 10){
                Text(" • Enter your word using the keyboard.").font(.custom("georgia", size: 18)).frame(maxWidth: .infinity, alignment: .leading)
                Text(" • Enter the same word in WORDLE.").font(.custom("georgia", size: 18)).frame(maxWidth: .infinity, alignment: .leading)
                Text(" • Once you hit \"Enter\" a menu will appear.").font(.custom("georgia", size: 18)).frame(maxWidth: .infinity, alignment: .leading)
                Text(" • Choose the options for each letter from \n    WORDLES result (i.e Correct for green, \n    Misplaced for yellow, and Unused for gray).").font(.custom("georgia", size: 18)).frame(maxWidth: .infinity, alignment: .leading)
                Text(" • Another menu will appear giving you the\n    top ten words.").font(.custom("georgia", size: 18)).frame(maxWidth: .infinity, alignment: .leading)
                Text(" • Hit \"OK\" and repeat until you solve.").font(.custom("georgia", size: 18)).frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack(spacing: 40){
                Image("start").resizable().scaledToFit().frame(width: 150)
                Image("select").resizable().scaledToFit().frame(width: 150)
            }.offset(x:-20)
            Button{
                dm.showHelp = false
            }label:{
                ZStack{
                    RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 50)
                    Text("OK").foregroundColor(.white)
                }.offset(y:25)
            }.offset(x:-20)
        }.offset(x: 20)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
            .environmentObject(WordleDataModel())
    }
}
