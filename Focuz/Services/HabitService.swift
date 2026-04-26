import Foundation
import SwiftData

@Observable
final class HabitService {
    var isPro: Bool = false

    func createHabit(modelContext: ModelContext, name: String, emoji: String, colorHex: String, frequency: HabitFrequency) {
        let count = (try? modelContext.fetch(FetchDescriptor<Habit>()).count) ?? 0
        if !isPro && count >= 5 {
            return
        }
        let habit = Habit(name: name, emoji: emoji, colorHex: colorHex)
        habit.frequency = frequency
        habit.order = count
        modelContext.insert(habit)
        try? modelContext.save()
    }

    func toggleCompletion(habit: Habit, modelContext: ModelContext) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let existing = habit.completions.first(where: { calendar.isDate($0.date, inSameDayAs: today) }) {
            existing.completed.toggle()
            existing.completedAt = existing.completed ? Date() : nil
        } else {
            let completion = HabitCompletion(date: today, completed: true)
            completion.completedAt = Date()
            completion.habit = habit
            modelContext.insert(completion)
        }
        try? modelContext.save()
    }

    func deleteHabit(_ habit: Habit, modelContext: ModelContext) {
        modelContext.delete(habit)
        try? modelContext.save()
    }

    func archiveHabit(_ habit: Habit, modelContext: ModelContext) {
        habit.isArchived = true
        try? modelContext.save()
    }

    func activeHabits(modelContext: ModelContext) -> [Habit] {
        let descriptor = FetchDescriptor<Habit>(
            predicate: #Predicate { !$0.isArchived },
            sortBy: [SortDescriptor(\.order)]
        )
        return (try? modelContext.fetch(descriptor)) ?? []
    }

    func canAddHabit(modelContext: ModelContext) -> Bool {
        if isPro { return true }
        let count = (try? modelContext.fetch(FetchDescriptor<Habit>()).count) ?? 0
        return count < 5
    }
}
