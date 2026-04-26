import Foundation

enum HabitFrequencyKind: String, Codable, CaseIterable {
    case daily
    case xPerWeek
    case xPerMonth
    case everyOtherDay
    case custom
}

enum HabitFrequency: Codable, Equatable, Hashable {
    case daily
    case xPerWeek(Int)
    case xPerMonth(Int)
    case everyOtherDay
    case custom([Int])

    var displayText: String {
        switch self {
        case .daily: return "Every day"
        case .xPerWeek(let x): return "\(x)x per week"
        case .xPerMonth(let x): return "\(x)x per month"
        case .everyOtherDay: return "Every other day"
        case .custom(let days):
            let names = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            return days.map { names[$0] }.joined(separator: ", ")
        }
    }

    var isFlexible: Bool {
        if case .daily = self { return false }
        return true
    }

    var weeklyTarget: Int {
        switch self {
        case .daily: return 7
        case .xPerWeek(let x): return x
        case .xPerMonth(let x): return max(1, x * 7 / 30)
        case .everyOtherDay: return 4
        case .custom(let days): return days.count
        }
    }

    var kind: HabitFrequencyKind {
        switch self {
        case .daily: return .daily
        case .xPerWeek: return .xPerWeek
        case .xPerMonth: return .xPerMonth
        case .everyOtherDay: return .everyOtherDay
        case .custom: return .custom
        }
    }

    static var allFrequencies: [HabitFrequency] {
        return [.daily, .xPerWeek(3), .xPerWeek(5), .xPerMonth(10), .everyOtherDay]
    }
}
