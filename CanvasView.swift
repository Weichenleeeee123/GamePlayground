import SwiftUI

struct CanvasView: View {
    
    @Binding var isWriting: Bool
    @Binding var currentCharacter: String
    
    @State private var lines: [Line] = []  // 存储书写的线条
    @State private var currentLine: Line? = nil  // 当前正在书写的线条
    
    // 设定书写区域的宽度和高度
    private let canvasWidth: CGFloat = 300
    private let canvasHeight: CGFloat = 300
    
    var body: some View {
        ZStack {
            // 显示书写的所有线条
            ForEach(lines, id: \.id) { line in
                Path { path in
                    path.addLines(line.points)
                }
                .stroke(Color.black, lineWidth: 2)
            }
            
            // 如果正在书写，显示当前书写的线条
            if let currentLine = currentLine {
                Path { path in
                    path.addLines(currentLine.points)
                }
                .stroke(Color.black, lineWidth: 2)
            }
        }
        .frame(width: canvasWidth, height: canvasHeight)  // 固定宽高，确保正方形
        .background(Color.white)  // 设置背景色，便于查看书写区域
        .border(Color.black, width: 1)  // 添加黑色边框
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    // 限制点的位置，防止超出正方形边界
                    let newLocation = CGPoint(
                        x: min(max(value.location.x, 0), canvasWidth),
                        y: min(max(value.location.y, 0), canvasHeight)
                    )
                    
                    // 开始书写时，记录初始点
                    if currentLine == nil {
                        currentLine = Line(id: UUID(), points: [newLocation])
                        print("手势开始位置: \(newLocation)")  // 控制台输出起始点
                    }
                    
                    // 添加新点到当前线条
                    currentLine?.points.append(newLocation)
                    print("添加点: \(newLocation)")  // 控制台输出每个添加的点
                }
                .onEnded { _ in
                    // 手势结束时，将当前线条保存到lines中
                    if let currentLine = currentLine {
                        lines.append(currentLine)
                        print("完成书写，添加线条: \(currentLine)")  // 控制台输出书写完成的线条
                    }
                    self.isWriting = false
                    self.currentLine = nil
                    
                    // 假设用户手写的字符是“书”
                    currentCharacter = "书"  // 临时设置为“书”
                    print("当前书写字符: \(currentCharacter)")  // 控制台输出当前字符
                }
        )
    }
}

struct Line {
    var id: UUID
    var points: [CGPoint]
}
