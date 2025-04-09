//
//  ContentView.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/8.
//

import SwiftUI //任何和 UI 有关的都需要导入 SwiftUI

struct ContentView: View {  //所有的东西都在 struct 里面
    var body: some View {  //var 表示变量
        HStack {
            CardView(isFaceup: false)
            CardView(isFaceup: true)
            CardView(isFaceup: false)
            CardView(isFaceup: true)
        }
        .foregroundColor(.red)
        .padding()
    }
}
struct CardView: View {
    @State var isFaceup: Bool = true //@State 暂时改变，
    var body: some View{
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12) // let 表示常量
            if isFaceup {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("🤖").font(.largeTitle)  //properties
            } else{
                base.fill()
                
            }
        }.onTapGesture {
            isFaceup.toggle() //bool运算函数，使得变量在 true 和 false 质检转换
        }
    }
}






















#Preview {
    ContentView()
}
