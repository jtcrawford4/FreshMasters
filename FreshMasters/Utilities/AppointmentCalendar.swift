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
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
        
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 200, height: 200)
                        .foregroundColor(.white)
                    
                    ZStack{
                        //MARK: - dont round bottom l or r
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 200, height: 60)
                            .foregroundColor(.red)
                            .offset(y: -70)
                        Text(appointmentMonth)
                            .offset(y: -70)
                            .foregroundColor(.white)
                            .font(.title2)
                        Text("\(appointmentDate)")
                            .fontWeight(.bold)
                            .font(.system(size: 60))
                            
                    }
                    Text(appointmentDay)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .offset(y: 50)
                }
                
            }
        }
    }
}

struct AppointmentCalendar_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentCalendar(date: Date())
    }
}
