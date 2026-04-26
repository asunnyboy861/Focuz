import Foundation

struct HabitScoreEngine {

    static func computeElasticScore(
        completions: [Bool],
        frequency: HabitFrequency
    ) -> Double {
        guard !completions.isEmpty else { return 0.0 }

        let decayFactor = 0.95
        var weightedScore = 0.0
        var totalWeight = 0.0

        for (index, completed) in completions.enumerated() {
            let daysAgo = completions.count - 1 - index
            let weight = pow(decayFactor, Double(daysAgo))
            totalWeight += weight

            if completed {
                weightedScore += weight
            } else {
                weightedScore += weight * 0.1
            }
        }

        return totalWeight > 0 ? weightedScore / totalWeight : 0.0
    }

    static func computeWeeklyRate(
        completionsThisWeek: Int,
        targetPerWeek: Int
    ) -> Double {
        guard targetPerWeek > 0 else { return 1.0 }
        return Double(min(completionsThisWeek, targetPerWeek)) / Double(targetPerWeek)
    }

    static func generateHeatmapData(completions: [Date: Bool], days: Int = 90) -> [HeatmapCell] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<days).map { offset in
            let date = calendar.date(byAdding: .day, value: -offset, to: today)!
            let completed = completions[calendar.startOfDay(for: date)] ?? false
            return HeatmapCell(
                date: date,
                completed: completed,
                intensity: completed ? 1.0 : 0.0
            )
        }
    }
}
