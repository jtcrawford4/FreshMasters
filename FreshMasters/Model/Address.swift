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

    var streetAddress = ""
    var city = ""
    private let state = "MO"
    var zip = ""
    private let shopCity = "Jefferson City"
    private let shopState = "MO"
    private let shopZip = "65109"
    var distanceToCustomer: Double = 0
    
    func calcDistanceToCustomer(){
        let group = DispatchGroup()
        let shopAddress = "Jefferson City, MO 65109"
        let customerAddress = "\(self.streetAddress) \(self.city),\(self.state) \(self.zip)"
        var shopCoordinate = CLLocationCoordinate2D()
        var customerCoordinate = CLLocationCoordinate2D()
        
        group.enter()
        getCoordinates(address: shopAddress) {  loc in
            shopCoordinate = loc
            group.leave()
        }
    
        group.enter()
        getCoordinates(address: customerAddress) {  loc in
            customerCoordinate = loc
            group.leave()
        }
        
        group.notify(queue: .main){
            print("coordinate: \(shopCoordinate)")
            print("coordinate: \(customerCoordinate)")
            let source          = MKPlacemark(coordinate: shopCoordinate)
            let destination     = MKPlacemark(coordinate: customerCoordinate)
            let request = MKDirections.Request()
            request.source      = MKMapItem(placemark: source)
            request.destination = MKMapItem(placemark: destination)
            request.transportType = MKDirectionsTransportType.automobile;

            // if getting more than one route,
            // requestsAlternateRoutes = true; else requestsAlternateRoutes = false;
            request.requestsAlternateRoutes = false

            let directions = MKDirections(request: request)

            directions.calculate { (response, error) in
                if let response = response, let route = response.routes.first {
                    print("distance: \(round(route.distance / 1609)) miles") //1609 meters per mile
                    self.distanceToCustomer = round(route.distance / 1609)
                }
            }
        }
    }
        
    private func getCoordinates(address: String, completion: @escaping ((CLLocationCoordinate2D) -> ())){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = (placemark?.location?.coordinate.latitude)
            let long = (placemark?.location?.coordinate.longitude)
            var coordinate = CLLocationCoordinate2D()
            if(lat == nil || long == nil){
                //MARK: - error handle
                coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
            }else{
                coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            }
            DispatchQueue.main.async {
                completion(coordinate)
            }
        }
    }
    
}
