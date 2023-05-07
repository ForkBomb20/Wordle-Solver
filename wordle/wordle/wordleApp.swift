//
//  wordleApp.swift
//  wordle
//
//  Created by Nathan Kawamoto on 3/4/23.
//

import SwiftUI

@main
struct wordleApp: App {
    @State var dm = WordleDataModel()
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(dm)
        }
    }
}
