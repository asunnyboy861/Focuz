import Foundation
import SwiftData

@Observable
final class InsightsViewModel {
    var selectedHabit: Habit?
    var heatmapDays: Int = 90

    func heatmapData(for habit: Habit) -> [HeatmapCell] {
        return HabitScoreEngine.generateHeatmapData(completions: habit.completionMap(), days: heatmapDays)
    }

    func bestDayOfWeek(for habit: Habit) -> String {
        let calendar = Calendar.current
        let dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        var dayCounts = [Int: Int]()

        for completion in habit.completions where completion.completed {
            let weekday = calendar.component(.weekday, from: completion.date)
            dayCounts[weekday, default: 0] += 1
        }

        guard let bestDay = dayCounts.max(by: { $0.value < $1.value })?.key else {
            return "Not enough data"
        }
        return dayNames[bestDay - 1]
    }

    func longestStreak(for habit: Habit) -> Int {
        let completions = habit.completions
            .filter { $0.completed }
            .map { Calendar.current.startOfDay(for: $0.date) }
            .sorted()

        guard !completions.isEmpty else { return 0 }

        var longest = 1
        var current = 1

        for i in 1..<completions.count {
            let daysBetween = Calendar.current.dateComponents([.day], from: completions[i-1], to: completions[i]).day ?? 0
            if daysBetween == 1 {
                current += 1
                longest = max(longest, current)
            } else {
                current = 1
            }
        }

        return longest
    }
}
