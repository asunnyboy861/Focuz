import Foundation
import SwiftData
import Observation

@Observable
final class TimerService {
    var activeSession: TimerSession?
    var tickCounter: Int = 0
    private var timer: Timer?

    func startTimer(habit: Habit, duration: TimeInterval, modelContext: ModelContext) {
        stopTimer(modelContext: modelContext)
        let session = TimerSession(targetDuration: duration)
        session.habit = habit
        modelContext.insert(session)
        activeSession = session
        try? modelContext.save()

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func stopTimer(modelContext: ModelContext) {
        activeSession?.isRunning = false
        activeSession?.endTime = Date()
        timer?.invalidate()
        timer = nil
        try? modelContext.save()
        activeSession = nil
    }

    func pauseTimer() {
        activeSession?.isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func resumeTimer() {
        guard let session = activeSession, !session.isRunning else { return }
        session.isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    private func tick() {
        tickCounter += 1
    }
}
