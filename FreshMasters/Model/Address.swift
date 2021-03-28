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
    
    func calcDistanceToCustomer() -> Double{
//        let semaphore = DispatchSemaphore(value: 0)
        let group = DispatchGroup()
        var miles: Double = 0
        
        let shopAddress = "Jefferson City, MO 65109"
        //        let customerAddress = "\(self.streetAddress) \(self.city),\(self.state) \(self.zip)"
        let customerAddress = "Linn, MO 65051"
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
                    miles = round(route.distance / 1609)
                }
            }
//            semaphore.signal()
        }
//        semaphore.wait()
        print("miles calc: \(miles)")
        return miles
    }
        
    private func getCoordinates(address: String, completion: @escaping ((CLLocationCoordinate2D) -> ())){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let shopLat = (placemark?.location?.coordinate.latitude)!
            let shopLong = (placemark?.location?.coordinate.longitude)!
//            print("address Lat: \(String(describing: shopLat)), Lon: \(String(describing: shopLong))")
            let coordinate = CLLocationCoordinate2D(latitude: shopLat, longitude: shopLong)
            DispatchQueue.main.async {
                completion(coordinate)
            }
        }
    }
    
}
