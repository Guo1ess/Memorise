//
//  ContentView.swift
//  Memorise
//
//  Created by GUO Ziqiang on 2025/4/8.
//

import SwiftUI //任何和 UI 有关的都需要导入 SwiftUI

struct ContentView: View {  //所有的东西都在 struct 里面
    var body: some View {
        HStack {
            CardView(isFaceup: true)
            CardView(isFaceup: true)
            CardView(isFaceup: false)
            CardView(isFaceup: true)
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct CardView: View {
    var isFaceup: Bool = false
    
    var body: some View{
        ZStack(content: {
            if isFaceup {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                Text("🤖").font(.largeTitle)  //properties
            } else{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.orange)
                
            }
        })

    }
}






















#Preview {
    ContentView()
}
