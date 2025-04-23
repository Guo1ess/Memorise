//
//  Untitled.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/11.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["👻","🤡","🐵","🐙","🧙","🐶","🦑","🐘","🐏","🦉","🐓"] // "static" makes the variable global but namespace it inside the function Then the real name of this var is EmojiMemoryGame.emojis. Don't need to pollute the namespace
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 11) { pairIndex in  //$0 means the first arguement
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]//  
            } else {
                return "⁇"
            }
        }
    }
    //information needed in the model. Also an initializer
    // private means 只有当前的代码能够使用这个变量 private to this class
    
   @Published private var model = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {  //"_" 在函数定义时，如果参数名称前加 _ ，表示在调用函数时不需要使用该参数的外部名称
        model.choose(card)
    }
}

