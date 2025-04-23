//
//  MemoriseApp.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/8.
//

import SwiftUI

@main
struct MemoriseApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
