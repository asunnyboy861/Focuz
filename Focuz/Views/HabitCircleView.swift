import SwiftUI

struct HabitCircleView: View {
    let habit: Habit
    let onTap: () -> Void

    @State private var showCompletionEffect = false

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.15), lineWidth: 4)

                    Circle()
                        .trim(from: 0, to: habit.todayElasticScore)
                        .stroke(
                            Color(hex: habit.colorHex),
                            style: StrokeStyle(lineWidth: 4, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))

                    Image(systemName: habit.emoji)
                        .font(.title2)
                        .foregroundColor(habit.isCompletedToday() ? Color(hex: habit.colorHex) : .secondary)

                    if showCompletionEffect {
                        Circle()
                            .fill(Color(hex: habit.colorHex).opacity(0.3))
                            .frame(width: 60, height: 60)
                            .scaleEffect(showCompletionEffect ? 2 : 1)
                            .opacity(showCompletionEffect ? 0 : 1)
                    }
                }
                .frame(width: 64, height: 64)

                Text(habit.name)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text("\(Int(habit.todayElasticScore * 100))%")
                    .font(.caption2.bold())
                    .foregroundColor(Color(hex: habit.colorHex))
            }
        }
        .buttonStyle(.plain)
        .onChange(of: habit.isCompletedToday()) { _, newValue in
            if newValue {
                withAnimation(.spring(duration: 0.5)) {
                    showCompletionEffect = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showCompletionEffect = false
                }
            }
        }
    }
}
