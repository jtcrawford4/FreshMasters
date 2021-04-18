//
//  ServiceTypeView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/17/21.
//

import SwiftUI

struct ServiceTypeView: View {
    
    @EnvironmentObject var order: Order
    @State private var interiorIsToggled = false
    @State private var exteriorIsToggled = false
    @State private var infoModalShowing = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                TitleText(text: "What detailing services are needed?")
                
                HStack(spacing: 10){
                    ToggleButton(toggleState: $interiorIsToggled, imageToggled: Image("icons8-steering-wheel-50-red"), imageNotToggled: Image("icons8-steering-wheel-50"), buttonText: "Interior")
                        .buttonStyle(SquareButtonStyle())
                        
                
                    ToggleButton(toggleState: $exteriorIsToggled, imageToggled: Image("icons8-car-cleaning-50-red"), imageNotToggled: Image("icons8-car-cleaning-50"), buttonText: "Exterior")
                        .buttonStyle(SquareButtonStyle())

                }
                .padding(.bottom, 40)
                
                VStack{
                    Button(action: {
                        infoModalShowing.toggle()
                    }, label: {
                        Text("What's included?")
                    })
                    
                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Next", isEnabled: (exteriorIsToggled || interiorIsToggled), content: {AdditionalServiceView()})
                        .frame(width: 160, height: 80)
                        .padding(.top, 40)
                        .simultaneousGesture(TapGesture().onEnded{
                            var temp = ""
                            if (exteriorIsToggled && interiorIsToggled) {
                                temp = Vehicle.serviceTypes.full.rawValue
                            }
                            else if (exteriorIsToggled){
                                temp = Vehicle.serviceTypes.exterior.rawValue
                            }
                            else if (interiorIsToggled){
                                temp = Vehicle.serviceTypes.interior.rawValue
                            }
                            order.vehicle.serviceType = temp
                            let vtype = order.vehicle.vehicleType
                            let stype = order.vehicle.serviceType
                            order.vehicle.hours.setBaseHours(
                                vehicleType: Vehicle.vehicleTypes(rawValue: vtype)!,
                                serviceType: Vehicle.serviceTypes(rawValue: stype)!)
                        })
                        .disabled(!(exteriorIsToggled || interiorIsToggled))
                }
        
                Spacer()
                
            }
            .sheet(isPresented: $infoModalShowing) {
                ServiceInfoSheet(modalShow: $infoModalShowing)
            }

        }
    }
}

struct ServiceInfoSheet: View{
    
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

struct ServiceTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceTypeView()
            .environmentObject(Order())
    }
}
