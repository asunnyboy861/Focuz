import SwiftData
import Foundation

@Model
final class HabitFrequencyData {
    @Attribute(.unique) var id: UUID
    var typeRaw: String
    var value: Int
    var customDays: [Int]

    var frequency: HabitFrequency {
        get {
            switch typeRaw {
            case "daily": return .daily
            case "xPerWeek": return .xPerWeek(value)
            case "xPerMonth": return .xPerMonth(value)
            case "everyOtherDay": return .everyOtherDay
            case "custom": return .custom(customDays)
            default: return .daily
            }
        }
        set {
            switch newValue {
            case .daily: typeRaw = "daily"; value = 0; customDays = []
            case .xPerWeek(let x): typeRaw = "xPerWeek"; value = x; customDays = []
            case .xPerMonth(let x): typeRaw = "xPerMonth"; value = x; customDays = []
            case .everyOtherDay: typeRaw = "everyOtherDay"; value = 0; customDays = []
            case .custom(let days): typeRaw = "custom"; value = 0; customDays = days
            }
        }
    }

    init(frequency: HabitFrequency) {
        self.id = UUID()
        self.typeRaw = "daily"
        self.value = 0
        self.customDays = []
        self.frequency = frequency
    }
}
