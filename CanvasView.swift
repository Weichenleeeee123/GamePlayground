import SwiftUI

struct CanvasView: View {
    
    @Binding var isWriting: Bool
    @Binding var currentCharacter: String
    
    @State private var lines: [Line] = []  // 存储书写的线条
    
    var body: some View {
        ZStack {
            ForEach(lines, id: \.id) { line in
                Path { path in
                    path.addLines(line.points)
                }
                .stroke(Color.black, lineWidth: 2)
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    isWriting = true
                    addLine(from: value.startLocation, to: value.location)
                }
                .onEnded { _ in
                    isWriting = false
                    // 在这里，可以处理字形的结束，并转换为字符
                    currentCharacter = "书"  // 示例，假设手写的是“书”
                }
        )
    }
    
    // 添加书写的线条
    private func addLine(from startPoint: CGPoint, to endPoint: CGPoint) {
        let newLine = Line(id: UUID(), points: [startPoint, endPoint])
        lines.append(newLine)
    }
}

struct Line {
    var id: UUID
    var points: [CGPoint]
}
