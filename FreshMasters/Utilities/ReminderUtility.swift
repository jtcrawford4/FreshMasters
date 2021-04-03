//
//  ReminderUtility.swift
//  FreshMasters
//
//  Created by John Crawford on 4/2/21.
//

import SwiftUI
import EventKit

func addReminder(title: String, note: String, date: Date) {
    let eventStore = EKEventStore()
    let dayBeforeAppointment = Calendar.current.date(byAdding: .day, value: -1, to: date)!
    
    eventStore.requestAccess(to: EKEntityType.reminder, completion: {granted, error in
        if (granted) && (error == nil) {

            let reminder:EKReminder = EKReminder(eventStore: eventStore)
            let alarm = EKAlarm(absoluteDate: dayBeforeAppointment)
            
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
