//
//  Address.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI
import CoreLocation
import MapKit

class Address{
    
    @Published var streetAddress = "2301 Maguire Blvd"
    @Published var city = "Columbia"
    @Published var state = "MO"
    @Published var zip = "65201"
    @Published var distanceToCustomer: Int = 0
    private let shopCity = "Jefferson City"
    private let shopState = "MO"
    
    func calcDistanceToCustomer(){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString("\(streetAddress) \(city),\(state) \(zip)") { (placemarks: [CLPlacemark]? , error: Error?) in
            if let placemarks = placemarks {
                let start_placemark = placemarks[0]
                geocoder.geocodeAddressString("\(self.shopCity), \(self.shopState)", completionHandler: { ( placemarks: [CLPlacemark]?, error: Error?) in
                    if let placemarks = placemarks {
                        let end_placemark = placemarks[0]

                        let start = MKMapItem(placemark: MKPlacemark(coordinate: start_placemark.location!.coordinate))
                        let end = MKMapItem(placemark: MKPlacemark(coordinate: end_placemark.location!.coordinate))

                        let request: MKDirections.Request = MKDirections.Request()
                        request.source = start
                        request.destination = end
                        request.transportType = MKDirectionsTransportType.automobile

                        let directions = MKDirections(request: request)
                        directions.calculate(completionHandler: { (response: MKDirections.Response?, error: Error?) in
                            if let routes = response?.routes {
                                let route = routes[0]
                                self.distanceToCustomer = Int(route.distance / 1609) //1609 meters per mile
                            }
                        })
                    }
                })
            }
        }
    }
    
}
