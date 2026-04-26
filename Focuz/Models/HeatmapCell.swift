import Foundation

struct HeatmapCell: Identifiable {
    let id = UUID()
    let date: Date
    let completed: Bool
    let intensity: Double
}
