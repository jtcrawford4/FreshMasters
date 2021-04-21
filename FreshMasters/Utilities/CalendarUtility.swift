//
//  CalendarUtility.swift
//  FreshMasters
//
//  Created by John Crawford on 4/20/21.
//

import SwiftUI
import EventKit

func addCalendarEvent(title: String, note: String, date: Date, workHours: Int) -> Bool{
    let eventStore = EKEventStore()
    var hours = workHours
    var appointmentStartDate = Calendar.current.date(bySetting: .hour, value: 8, of: date)
    appointmentStartDate = Calendar.current.date(byAdding: .day, value: -1, to: appointmentStartDate!)
    var appointmentEndDate: Date
    
    if(hours > 9){
        appointmentEndDate = Calendar.current.date(byAdding: .hour, value: 9, to: appointmentStartDate!)!
    }else{
        appointmentEndDate = Calendar.current.date(byAdding: .hour, value: hours, to: appointmentStartDate!)!
    }
    
    let authorized: Bool = checkCalendarAuthorizationStatus()
    
    if(authorized){
        repeat{
            let event = generateEvent(eventStore: eventStore,
                                      title: title,
                                      startDate: appointmentStartDate!,
                                      endDate: appointmentEndDate,
                                      note: note)
            
            do{
                try eventStore.save(event, span: .thisEvent)
            }catch let error as NSError {
                print("failed to save event with error : \(error)")
                return false
            }
            
            hours = hours - 9
            if(hours > 0){
                appointmentStartDate = Calendar.current.date(byAdding: .day, value: 1, to: appointmentStartDate!)
                appointmentEndDate = Calendar.current.date(byAdding: .hour, value: (hours > 9 ? 9 : hours), to: appointmentStartDate!)!
            }
        }while hours > 0
        
        print("Saved Event")
        return true
        
    }else{
        print("failed auth")
        return false
    }
    
}

private func generateEvent(eventStore: EKEventStore, title: String, startDate: Date, endDate: Date, note: String) -> EKEvent{
    let event:EKEvent = EKEvent(eventStore: eventStore)
    event.title = title
    event.startDate = startDate
    event.endDate = endDate
    event.notes = note
    event.url = URL(string: "http://freshmastersdetail.com/")
    event.calendar = eventStore.defaultCalendarForNewEvents
    return event
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
