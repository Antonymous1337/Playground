//
//  NotificationPractice.swift
//  Playground
//
//  Created by Antony Holshouser on 1/15/25.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotificationByTimeInterval() {
        
        let content = UNMutableNotificationContent()
        content.title = "Time Interval Notification"
        content.subtitle = "This is my first notification"
        content.sound = .default
        content.badge = 1
        
        // triggers can be time, calendar, and location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "My Notification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func scheduleNotificationByCalendar() {
        
        let content = UNMutableNotificationContent()
        content.title = "Calendar Notification"
        content.subtitle = "This is my second notification"
        content.sound = .defaultCritical
        content.badge = 1
        
        // triggers can be time, calendar, and location
        
        // SCHEDULED for the NEXT MINUTE
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Calendar.current.date(byAdding: DateComponents(minute: 1), to: Date())!)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "My Notification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func removeNotifications() {
        // Removes all notifications to be delivered
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // Removes notifications that were already triggered and are still currently displayed in the users notification center and/or lock screen (that they just haven't closed yet)
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}

struct NotificationPracticeMain: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                // You can only request this ONCE!!! Make sure to include a pop up for why it's important, and only display THAT until they say yes.
                NotificationManager.instance.requestAuthorization()
            }
            
            Button("Schedule Notification for 5 Seconds via Time Interval") {
                NotificationManager.instance.scheduleNotificationByTimeInterval()
            }
            
            Button("Schedule Notification for Next Minute via Calendar") {
                NotificationManager.instance.scheduleNotificationByCalendar()
            }
            
            Button("Cancel Notifications and Remove from Notification Center") {
                NotificationManager.instance.removeNotifications()
            }
        }
        .padding(.horizontal)
        .onAppear {
            // Manually reset badge
            UNUserNotificationCenter.current().setBadgeCount(0)
        }
    }
}

#Preview {
    NotificationPracticeMain()
}
