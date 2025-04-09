//
//  ContentView.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/8.
//

import SwiftUI //任何和 UI 有关的都需要导入 SwiftUI

struct ContentView: View {  //所有的东西都在 struct 里面
    let emojis: Array<String> = ["👻","🤡","🐵","🐙","🧙","🐶","🦑","🐵","🐙","🧙"]
    
    @State var cardCount: Int = 4
    
    var body: some View {  //var 表示变量 在 view builder 中只能使用条件判断、列表和局部变量
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode:  .fit)
            } //0..<4 不包括 4，共有 4 个数； 0...4 包括 4，共有 5 个元素
        }
        .foregroundColor(.orange)
    }
    
    var cardAdjusters: some View {
        HStack{
            cardRomover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)//防止程序崩溃
        }
        
    var cardRomover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
       
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")

    }
}
    
    struct CardView: View {
        let content: String //需要变换 emoji 内容
        @State var isFaceup: Bool = true //@State 暂时改变，
        var body: some View{
            ZStack {
                let base = RoundedRectangle(cornerRadius: 12) // let 表示常量
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
                }
                .opacity(isFaceup ? 1: 0)
                base.fill().opacity(isFaceup ? 0 : 1)
            }.onTapGesture {
                isFaceup.toggle() //bool运算函数，使得变量在 true 和 false 质检转换
            }
        }
    }
    
    #Preview {
        ContentView()
    }
