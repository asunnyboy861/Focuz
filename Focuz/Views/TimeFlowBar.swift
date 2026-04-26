import SwiftUI

struct TimeFlowBar: View {
    let progress: Double
    let color: Color
    let isRunning: Bool

    @State private var pulsePhase: Double = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.15))

                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            colors: [color.opacity(0.6), color],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width * CGFloat(progress))

                if isRunning && progress < 1.0 {
                    Circle()
                        .fill(color)
                        .frame(width: 12, height: 12)
                        .offset(x: geometry.size.width * CGFloat(progress) - 6)
                        .blur(radius: 3 + sin(pulsePhase) * 2)
                }
            }
        }
        .frame(height: 16)
        .onAppear {
            withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                pulsePhase = .pi
            }
        }
    }
}
