import Foundation
import UserNotifications

@Observable
final class NotificationService {
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func scheduleReminder(for habit: Habit) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        for time in habit.reminderTimes {
            let content = UNMutableNotificationContent()
            content.title = "Focuz"
            content.body = "Time to \(habit.name) \(habit.emoji)"
            content.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
            let request = UNNotificationRequest(identifier: "\(habit.id.uuidString)-\(time.hour ?? 0)-\(time.minute ?? 0)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }

    func cancelReminders(for habit: Habit) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
