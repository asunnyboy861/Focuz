import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Habit> { !$0.isArchived }, sort: \Habit.order) private var habits: [Habit]
    @State private var viewModel = TodayViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    headerSection
                    timeFlowSection
                    habitsSection
                    miniHeatmapSection
                }
                .padding()
            }
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#FFF8F0"))
            .navigationTitle("")
        }
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: viewModel.greetingEmoji)
                    .font(.title2)
                Text(viewModel.greeting)
                    .font(.title2.bold())
                Spacer()
            }

            Text("You're \(Int(viewModel.weeklyConsistency * 100))% consistent this week")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.top, 8)
    }

    private var timeFlowSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Time")
                .font(.headline)

            TimeFlowBar(progress: viewModel.dayProgress, color: Color(hex: "#8CB369"), isRunning: true)

            Text(viewModel.remainingHoursText)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }

    private var habitsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Today's Habits")
                    .font(.headline)
                Spacer()
                if habits.isEmpty {
                    NavigationLink(destination: BuildView()) {
                        Text("Add Habit")
                            .font(.subheadline)
                            .foregroundColor(Color(hex: "#8CB369"))
                    }
                }
            }

            if habits.isEmpty {
                emptyStateView
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {
                    ForEach(habits) { habit in
                        HabitCircleView(habit: habit) {
                            viewModel.toggleHabit(habit, modelContext: modelContext)
                        }
                    }
                }
            }
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 40))
                .foregroundColor(Color(hex: "#8CB369"))
            Text("No habits yet")
                .font(.headline)
            Text("Tap Build to create your first habit")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }

    private var miniHeatmapSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("This Week")
                .font(.headline)

            HStack(spacing: 4) {
                ForEach(0..<7, id: \.self) { dayOffset in
                    let calendar = Calendar.current
                    let today = calendar.startOfDay(for: Date())
                    let date = calendar.date(byAdding: .day, value: -(6 - dayOffset), to: today)!
                    let dayCompletions = habits.filter { habit in
                        habit.completions.contains { cal in
                            calendar.isDate(cal.date, inSameDayAs: date) && cal.completed
                        }
                    }.count
                    let totalActive = habits.count
                    let ratio = totalActive > 0 ? Double(dayCompletions) / Double(totalActive) : 0

                    RoundedRectangle(cornerRadius: 4)
                        .fill(ratio > 0 ? Color(hex: "#8CB369").opacity(ratio) : Color.gray.opacity(0.15))
                        .frame(height: 28)
                }
            }

            HStack {
                Text("Mon")
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Spacer()
                Text("Sun")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
    }
}
