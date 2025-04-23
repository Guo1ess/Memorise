//
//  EmojiMemoryGameView.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/8.
//

import SwiftUI //任何和 UI 有关的都需要导入 SwiftUI

struct EmojiMemoryGameView: View {  //所有的东西都在 struct 里面
    @ObservedObject var viewModel: EmojiMemoryGame  //@ObservedObject means something changed, redraw me. Never say equal here. On contrary, @StateObject can be with an equal
    
    var body: some View {  //var 表示变量 在 view builder 中只能使用条件判断、列表和局部变量
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards){ card in
                CardView(card)
                    .aspectRatio(2/3, contentMode:  .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            } //0..<4 不包括 4，共有 4 个数； 0...4 包括 4，共有 5 个元素
        }
        .foregroundColor(Color.orange)
    }
}
    
struct CardView: View {
    let card: MemoryGame<String>.Card
    
   // init(card: MemoryGame<String>.Card) {
    //   self.card = card
    //}
    //equivalent free init
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group  {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit) //调整视图大小
            }
                .opacity(card.isFaceUp ? 1:0)
            base.fill()
                .opacity(card.isFaceUp ? 0:1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}
    
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
