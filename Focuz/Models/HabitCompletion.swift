import SwiftData
import Foundation

@Model
final class HabitCompletion {
    @Attribute(.unique) var id: UUID
    var date: Date
    var completed: Bool
    var note: String?
    var completedAt: Date?

    var habit: Habit?

    init(date: Date, completed: Bool) {
        self.id = UUID()
        self.date = date
        self.completed = completed
    }
}
