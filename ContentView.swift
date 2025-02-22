import SwiftUI

struct ContentView: View {
    
    @State private var isWriting = false
    @State private var currentCharacter = ""  // 当前书写的字
    @State private var displayedCharacter = "书"  // 显示的字形，初始为现代汉字
    
    var body: some View {
        VStack {
            // 顶部的水墨画区域（暂时用文字表示）
            Text("水墨画展示")
                .font(.title)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
            
            // 书写区域
            CanvasView(isWriting: $isWriting, currentCharacter: $currentCharacter)
                .frame(height: 200)
                .border(Color.black, width: 1)
            
            Spacer()
            
            // 确认按钮
            Button(action: {
                confirmWriting()
            }) {
                Text("确认")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
            
            // 显示字形
            Text("字形演变：\(displayedCharacter)")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
        }
        .padding()
    }
    
    // 确认书写并触发字形演变
    func confirmWriting() {
        print("点击确认，当前书写的字符是: \(currentCharacter)")  // 控制台输出点击确认时的字符
        // 模拟字形演变（从现代汉字到甲骨文）
        let animation = CharacterAnimation()
        animation.animateToOracle(character: currentCharacter) { 
            self.displayedCharacter = "甲骨文"  // 假设字形演变成甲骨文
            print("字形演变为: \(self.displayedCharacter  "")")  // 控制台输出字形演变结果
        }
    }
}