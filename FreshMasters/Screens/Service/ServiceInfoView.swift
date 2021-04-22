//
//  ServiceInfoView.swift
//  FreshMasters
//
//  Created by John Crawford on 4/22/21.
//

import SwiftUI

struct ServiceInfoView: View {
    
    @Binding var modalShow: Bool
    @State private var selectedTag = 0
    
    var body: some View{
        let interiorServices = ["Carpets Vacuumed",
                                "Floor Mats Cleaned",
                                "Trunk Vacuumed",
                                "Seats Cleaned/Vacuumed",
                                "Carpets Steam Cleaned",
                                "Seats Steam Cleaned",
                                "Glass Cleaned",
                                "Dash Cleaned/Dressed",
                                "Door Panels Cleaned/Dressed",
                                "Cup Holders/Console Cleaned",
                                "Seat Base Cleaned",
                                "Vents Cleaned",
                                "Leather Cleaned/Conditioned",
                                "Mild to Moderate Stain Removal"]

        let exteriorServices = ["Hand Wash",
                                "Glass Cleaned",
                                "Wheels Cleaned",
                                "Door Jambs Cleaned",
                                "Tires Cleaned/Dressed",
                                "Wheel Wells Dressed",
                                "Chrome/Stainless Polished",
                                "Clay Painted Surfaces",
                                "High Quality Wax Application",
                                "Rain-X Application"]
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
        
            VStack{
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 40)
                
                Text("Service Detail")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Picker("", selection: $selectedTag) {
                    Text("Interior").tag(0)
                    Text("Exterior").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .foregroundColor(.blue)
                .padding(25)
    
                ScrollView (.vertical, showsIndicators: true) {
                    let serviceList = (selectedTag == 0 ? interiorServices : exteriorServices)
                    ForEach(serviceList, id: \.self){ service in
                        Text("\(service)\n")
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 400)
                
                Button(action: {
                    modalShow.toggle()
                }, label: {
                    Text("Close")
                })
                .frame(width: 140, height: 40)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(4.0)
            }
            
        }
    }
}

struct ServiceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceInfoView(modalShow: .constant(true))
    }
}
