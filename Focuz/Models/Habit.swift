import SwiftData
import Foundation

@Model
final class Habit {
    @Attribute(.unique) var id: UUID
    var name: String
    var emoji: String
    var colorHex: String
    var frequencyData: HabitFrequencyData?
    var createdAt: Date
    var order: Int
    var isArchived: Bool
    var reminderTimes: [DateComponents]
    var completionSound: String?

    @Relationship(deleteRule: .cascade, inverse: \HabitCompletion.habit) var completions: [HabitCompletion]
    @Relationship(deleteRule: .cascade, inverse: \TimerSession.habit) var timerSessions: [TimerSession]

    var frequency: HabitFrequency {
        get { frequencyData?.frequency ?? .daily }
        set {
            if frequencyData == nil {
                frequencyData = HabitFrequencyData(frequency: newValue)
            } else {
                frequencyData?.frequency = newValue
            }
        }
    }

    init(name: String, emoji: String = "star.fill", colorHex: String = "#8CB369") {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
        self.colorHex = colorHex
        self.frequencyData = HabitFrequencyData(frequency: .daily)
        self.createdAt = Date()
        self.order = 0
        self.isArchived = false
        self.reminderTimes = []
        self.completions = []
        self.timerSessions = []
    }

    var todayElasticScore: Double {
        let recentCompletions = completions
            .sorted { $0.date > $1.date }
            .prefix(30)
            .map { $0.completed }
        return HabitScoreEngine.computeElasticScore(
            completions: Array(recentCompletions),
            frequency: frequency
        )
    }

    var weeklyCompletionRate: Double {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
        let thisWeekCompletions = completions.filter { $0.date >= startOfWeek && $0.completed }.count
        return HabitScoreEngine.computeWeeklyRate(
            completionsThisWeek: thisWeekCompletions,
            targetPerWeek: frequency.weeklyTarget
        )
    }

    func isCompletedToday() -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return completions.contains { calendar.isDate($0.date, inSameDayAs: today) && $0.completed }
    }

    func completionMap() -> [Date: Bool] {
        let calendar = Calendar.current
        var map = [Date: Bool]()
        for completion in completions {
            let key = calendar.startOfDay(for: completion.date)
            map[key] = completion.completed
        }
        return map
    }
}
