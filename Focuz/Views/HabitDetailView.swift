import SwiftUI
import SwiftData

struct HabitDetailView: View {
    @Environment(\.modelContext) private var modelContext
    let habit: Habit
    @State private var timerService = TimerService()
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerSection
                ElasticScoreRing(score: habit.todayElasticScore, color: Color(hex: habit.colorHex))
                    .frame(width: 160, height: 160)
                statsSection
                timerSection
            }
            .padding()
        }
        .frame(maxWidth: 720)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#FFF8F0"))
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var headerSection: some View {
        HStack(spacing: 16) {
            Image(systemName: habit.emoji)
                .font(.largeTitle)
                .foregroundColor(Color(hex: habit.colorHex))
                .frame(width: 56, height: 56)
                .background(Color(hex: habit.colorHex).opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.title2.bold())
                Text(habit.frequency.displayText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }

    private var statsSection: some View {
        VStack(spacing: 12) {
            HStack {
                StatItem(title: "This Week", value: "\(Int(habit.weeklyCompletionRate * 100))%", color: Color(hex: habit.colorHex))
                StatItem(title: "Elastic Score", value: "\(Int(habit.todayElasticScore * 100))%", color: Color(hex: habit.colorHex))
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var timerSection: some View {
        VStack(spacing: 12) {
            Text("Timer")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            if timerService.activeSession != nil {
                activeTimerView
            } else {
                timerStartButtons
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var activeTimerView: some View {
        VStack(spacing: 12) {
            if let session = timerService.activeSession {
                TimeFlowBar(progress: session.progress, color: Color(hex: habit.colorHex), isRunning: session.isRunning)

                Text(formatTime(session.remaining))
                    .font(.system(.title, design: .monospaced))

                HStack(spacing: 16) {
                    Button {
                        if session.isRunning {
                            timerService.pauseTimer()
                        } else {
                            timerService.resumeTimer()
                        }
                    } label: {
                        Image(systemName: session.isRunning ? "pause.fill" : "play.fill")
                            .font(.title2)
                            .foregroundColor(Color(hex: habit.colorHex))
                    }

                    Button {
                        timerService.stopTimer(modelContext: modelContext)
                    } label: {
                        Image(systemName: "stop.fill")
                            .font(.title2)
                            .foregroundColor(.red.opacity(0.7))
                    }
                }
            }
        }
    }

    private var timerStartButtons: some View {
        HStack(spacing: 12) {
            TimerPresetButton(title: "5 min", duration: 300, habit: habit, timerService: timerService, modelContext: modelContext)
            TimerPresetButton(title: "15 min", duration: 900, habit: habit, timerService: timerService, modelContext: modelContext)
            TimerPresetButton(title: "30 min", duration: 1800, habit: habit, timerService: timerService, modelContext: modelContext)
        }
    }

    private func formatTime(_ seconds: TimeInterval) -> String {
        let mins = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%d:%02d", mins, secs)
    }
}

struct StatItem: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct TimerPresetButton: View {
    let title: String
    let duration: TimeInterval
    let habit: Habit
    let timerService: TimerService
    let modelContext: ModelContext

    var body: some View {
        Button {
            timerService.startTimer(habit: habit, duration: duration, modelContext: modelContext)
        } label: {
            Text(title)
                .font(.subheadline.bold())
                .foregroundColor(Color(hex: habit.colorHex))
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color(hex: habit.colorHex).opacity(0.15))
                .clipShape(Capsule())
        }
    }
}
