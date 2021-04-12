//
//  ReminderUtility.swift
//  FreshMasters
//
//  Created by John Crawford on 4/2/21.
//

import SwiftUI
import EventKit


func addReminder(title: String, note: String, date: Date){
    let eventStore = EKEventStore()
    let appointmentReminderDate = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: date)
    eventStore.requestAccess(to: EKEntityType.reminder, completion: {granted, error in
        if (granted) && (error == nil) {

            let reminder:EKReminder = EKReminder(eventStore: eventStore)
            let alarm = EKAlarm(absoluteDate: appointmentReminderDate!)
            
            reminder.title = title
            reminder.notes = note
            reminder.addAlarm(alarm)
            reminder.calendar = eventStore.defaultCalendarForNewReminders()

            do {
              try eventStore.save(reminder, commit: true)
            } catch {
              print("Cannot save")
              return
            }
            print("Reminder saved")
        }
    })
}

func checkReminderAuthorizationStatus() -> Bool {
    let status = EKEventStore.authorizationStatus(for: EKEntityType.reminder)
    switch (status) {
    case EKAuthorizationStatus.notDetermined:
        //first run of app
        return true
    case EKAuthorizationStatus.authorized:
        return true
    case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
        return false
    @unknown default:
        return false
    }
}

struct ReminderAlerts{
    static let reminderNotAuthorized = AlertItem(title: Text("Permissions Required"), message: Text("Update settings to allow FreshMasters to create appointment reminders."), dismissButton: .default(Text("OK")))
    
    static let reminderSet = AlertItem(title: Text("Reminder Set"), message: Text("Alarm set for 8 am the morning of appointment."), dismissButton: .default(Text("OK")))
}
