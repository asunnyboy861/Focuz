import SwiftUI

struct ElasticScoreRing: View {
    let score: Double
    let color: Color

    @State private var animatedScore: Double = 0

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.15), lineWidth: 10)

            Circle()
                .trim(from: 0, to: animatedScore)
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))

            VStack(spacing: 2) {
                Text("\(Int(animatedScore * 100))%")
                    .font(.title.bold())
                    .foregroundColor(color)

                Text(encouragingText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            withAnimation(.spring(duration: 1.0)) {
                animatedScore = score
            }
        }
        .onChange(of: score) { _, newValue in
            withAnimation(.spring(duration: 0.5)) {
                animatedScore = newValue
            }
        }
    }

    private var encouragingText: String {
        switch score {
        case 0..<0.3: return "Just getting started"
        case 0.3..<0.5: return "Building momentum"
        case 0.5..<0.7: return "You're showing up"
        case 0.7..<0.9: return "You're doing great"
        default: return "Outstanding consistency"
        }
    }
}
