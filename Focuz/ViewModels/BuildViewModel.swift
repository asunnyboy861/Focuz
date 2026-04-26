import Foundation
import SwiftData
import UIKit

@Observable
final class BuildViewModel {
    var name: String = ""
    var selectedEmoji: String = "star.fill"
    var selectedColor: String = "#8CB369"
    var selectedFrequencyKind: HabitFrequencyKind = .daily
    var customWeekCount: Int = 3
    var customMonthCount: Int = 10

    let availableEmojis = [
        "star.fill", "heart.fill", "flame.fill", "drop.fill",
        "book.fill", "figure.run", "brain.head.profile.fill",
        "leaf.fill", "moon.fill", "sun.max.fill", "dumbbell.fill",
        "pill.fill", "cup.and.saucer.fill", "bed.double.fill",
        "pencil", "music.note", "bicycle", "car.fill"
    ]

    let availableColors = [
        "#8CB369", "#F4A261", "#6A9BD2", "#E07A5F",
        "#81B29A", "#F2CC8F", "#3D405B", "#D4A5A5",
        "#9B8EC1", "#5DADE2", "#F1948A", "#82E0AA"
    ]

    var canSave: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func reset() {
        name = ""
        selectedEmoji = "star.fill"
        selectedColor = "#8CB369"
        selectedFrequencyKind = .daily
        customWeekCount = 3
        customMonthCount = 10
    }

    func effectiveFrequency() -> HabitFrequency {
        switch selectedFrequencyKind {
        case .daily:
            return .daily
        case .xPerWeek:
            return .xPerWeek(customWeekCount)
        case .xPerMonth:
            return .xPerMonth(customMonthCount)
        case .everyOtherDay:
            return .everyOtherDay
        case .custom:
            return .custom([])
        }
    }
}
