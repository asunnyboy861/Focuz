import SwiftUI
import SwiftData

@main
struct FocuzApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Habit.self, HabitCompletion.self, TimerSession.self, HabitFrequencyData.self])
    }
}
