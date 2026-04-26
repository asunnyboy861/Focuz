import SwiftUI
import SwiftData

struct InsightsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(filter: #Predicate<Habit> { !$0.isArchived }, sort: \Habit.order) private var habits: [Habit]
    @State private var viewModel = InsightsViewModel()
    @State private var selectedHabit: Habit?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let habit = selectedHabit {
                        habitDetailSection(habit: habit)
                    } else if habits.isEmpty {
                        emptyStateView
                    } else {
                        habitPickerSection
                    }
                }
                .padding()
            }
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#FFF8F0"))
            .navigationTitle("Insights")
        }
    }

    private var habitPickerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Select a Habit")
                .font(.headline)

            ForEach(habits) { habit in
                Button {
                    selectedHabit = habit
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: habit.emoji)
                            .font(.title3)
                            .foregroundColor(Color(hex: habit.colorHex))
                            .frame(width: 36, height: 36)
                            .background(Color(hex: habit.colorHex).opacity(0.15))
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.subheadline.bold())
                                .foregroundColor(.primary)
                            Text("\(Int(habit.todayElasticScore * 100))% consistent")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func habitDetailSection(habit: Habit) -> some View {
        VStack(spacing: 20) {
            Button {
                selectedHabit = nil
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                    Spacer()
                }
                .foregroundColor(Color(hex: "#8CB369"))
            }

            HStack(spacing: 12) {
                Image(systemName: habit.emoji)
                    .font(.largeTitle)
                    .foregroundColor(Color(hex: habit.colorHex))
                Text(habit.name)
                    .font(.title2.bold())
                Spacer()
            }

            HeatmapView(cells: viewModel.heatmapData(for: habit), color: Color(hex: habit.colorHex))

            ElasticScoreRing(score: habit.todayElasticScore, color: Color(hex: habit.colorHex))
                .frame(width: 140, height: 140)

            VStack(spacing: 8) {
                Text("Frequency: \(habit.frequency.displayText)")
                    .font(.subheadline)
                Text("This week: \(Int(habit.weeklyCompletionRate * 100))% completed")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Best day: \(viewModel.bestDayOfWeek(for: habit))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Longest run: \(viewModel.longestStreak(for: habit)) days")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 12) {
            Image(systemName: "chart.bar.fill")
                .font(.system(size: 40))
                .foregroundColor(Color(hex: "#8CB369"))
            Text("No habits to analyze")
                .font(.headline)
            Text("Create habits first to see insights")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}
