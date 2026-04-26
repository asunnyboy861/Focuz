import Foundation
import SwiftData
import UIKit

@Observable
final class TodayViewModel {
    var habitService = HabitService()
    var showingPaywall = false

    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<6: return "Good Night"
        case 6..<12: return "Good Morning"
        case 12..<17: return "Good Afternoon"
        case 17..<21: return "Good Evening"
        default: return "Good Night"
        }
    }

    var greetingEmoji: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<6: return "moon.stars.fill"
        case 6..<12: return "sunrise.fill"
        case 12..<17: return "sun.max.fill"
        case 17..<21: return "sunset.fill"
        default: return "moon.stars.fill"
        }
    }

    var dayProgress: Double {
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        let totalSeconds = endOfDay.timeIntervalSince(startOfDay)
        let elapsedSeconds = now.timeIntervalSince(startOfDay)
        return min(1.0, elapsedSeconds / totalSeconds)
    }

    var remainingHoursText: String {
        let calendar = Calendar.current
        let now = Date()
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: now))!
        let remaining = endOfDay.timeIntervalSince(now)
        let hours = Int(remaining / 3600)
        return "You have \(hours)h left today"
    }

    var weeklyConsistency: Double {
        return 0.83
    }

    func toggleHabit(_ habit: Habit, modelContext: ModelContext) {
        habitService.toggleCompletion(habit: habit, modelContext: modelContext)
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}
