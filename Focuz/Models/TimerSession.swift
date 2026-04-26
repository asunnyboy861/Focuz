import SwiftData
import Foundation

@Model
final class TimerSession {
    @Attribute(.unique) var id: UUID
    var startTime: Date
    var endTime: Date?
    var targetDuration: TimeInterval
    var isRunning: Bool

    var habit: Habit?

    init(targetDuration: TimeInterval) {
        self.id = UUID()
        self.startTime = Date()
        self.targetDuration = targetDuration
        self.isRunning = true
    }

    var elapsed: TimeInterval {
        if isRunning {
            return Date().timeIntervalSince(startTime)
        }
        return endTime?.timeIntervalSince(startTime) ?? 0
    }

    var remaining: TimeInterval {
        return max(0, targetDuration - elapsed)
    }

    var progress: Double {
        return min(1.0, elapsed / targetDuration)
    }
}
