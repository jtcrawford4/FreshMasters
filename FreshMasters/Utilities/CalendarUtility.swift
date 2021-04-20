//
//  CalendarUtility.swift
//  FreshMasters
//
//  Created by John Crawford on 4/20/21.
//

import SwiftUI
import EventKit


func addCalendarEvent(title: String, note: String, date: Date){
    let eventStore = EKEventStore()
    //MARK: - get high hours. if more than 8, add another day
    var appointmentStartDate = Calendar.current.date(bySetting: .hour, value: 8, of: date)
    appointmentStartDate = Calendar.current.date(byAdding: .day, value: -1, to: appointmentStartDate!)
    let appointmentEndDate = Calendar.current.date(byAdding: .hour, value: 9, to: appointmentStartDate!)

    eventStore.requestAccess(to: .event) { (granted, error) in
        if (granted) && (error == nil) {
            
            let event:EKEvent = EKEvent(eventStore: eventStore)
            
            event.title = title
            event.startDate = appointmentStartDate
            event.endDate = appointmentEndDate
            event.notes = note
            event.calendar = eventStore.defaultCalendarForNewEvents
            
            do {
                try eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
                print("failed to save event with error : \(error)")
            }
            print("Saved Event")
        }
        else{
            print("failed to save event with error : \(String(describing: error)) or access not granted")
        }
    }
}

func checkCalendarAuthorizationStatus() -> Bool {
    let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
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

struct CalendarAlerts{
    static let calendarNotAuthorized = AlertItem(title: Text("Permissions Required"), message: Text("Update settings to allow FreshMasters to create calendar events for appointments. \n\nChanging settings will restart app."), dismissButton: .default(Text("OK")))
    
    static let calendarSet = AlertItem(title: Text("Calendar Set"), message: Text("Appointment saved to calendar!"), dismissButton: .default(Text("OK")))
    
    static let calendarError = AlertItem(title: Text("Calendar Error"), message: Text("Appointment could not be saved to calendar. \nNo need to worry, your appointment has already been sent to FreshMasters."), dismissButton: .default(Text("OK")))
}
