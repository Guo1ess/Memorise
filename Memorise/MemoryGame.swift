//
//  MemoryGame.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/11.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    //access control
    // need to be adressed
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [] //[]means an empty array
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) { //_ underbar: just don't put anything here
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))  // \(pairIndex) is a swift feature: interpolation
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
           // cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    
    mutating func shuffle() {  //mutating
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp  = false
        var isMatched  = false
        let content: CardContent //每张卡片的内容是个定值，所以不是 variable
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down")\(isMatched ? "matched" : "")"
        }
    }
}


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
