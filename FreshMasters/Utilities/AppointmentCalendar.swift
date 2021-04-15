//
//  AppointmentCalendar.swift
//  FreshMasters
//
//  Created by John Crawford on 4/1/21.
//

import SwiftUI

struct AppointmentCalendar: View {
    
    var components: DateComponents
    var appointmentDate: Int
    var appointmentMonth: String
    var appointmentDay: String
    let dateFormatter = DateFormatter()
    
    init(date: Date){
        components = Calendar.current.dateComponents([.day], from: date)
        appointmentDate = components.day!
        dateFormatter.dateFormat = "LLLL"
        appointmentMonth = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "EEEE"
        appointmentDay = dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 135, height: 90)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .offset(y: -10)
                
                ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 135, height: 40)
                        .offset(y: -70)
                    Text("\(appointmentMonth)")
                        .fontWeight(.semibold)
                        .offset(y: -70)
                        .foregroundColor(.white)
                        .font(.title2)
                    Text("\(appointmentDate)")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .font(.system(size: 45))
                        .offset(y: -20)
                }
                
                Text(appointmentDay)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .offset(y: 15)
            }
        }
    }
}

struct AppointmentCalendar_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentCalendar(date: Date())
    }
}
