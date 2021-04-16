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
    var state = ""
    var zip = ""
    private let shopCity = "Jefferson City"
    private let shopState = "MO"
    private let shopZip = "65109"
    var distanceToCustomer: Double = 0
    private let mileageThreshold: Double = 60
    
    func getDistanceToCustomer(completed: @escaping (Result<Double, FmError>) -> Void){
        let group = DispatchGroup()
        let shopAddress = "Jefferson City, MO 65109"
        let customerAddress = "\(self.streetAddress) \(self.city),\(self.state) \(self.zip)"
        var shopCoordinate = CLLocationCoordinate2D()
        var customerCoordinate = CLLocationCoordinate2D()
        
        if (self.city.isEmpty || self.state.isEmpty || self.zip.isEmpty){
            return completed(.failure(.invalidAddress))
        }
        
        if(self.state.lowercased() == "pa" || self.state.lowercased() == "pennsylvania"){
            return completed(.failure(.pennsylvania))
        }
        
        group.enter()
        getCoordinates(address: shopAddress) {  result in
            switch result {
                case .success(let coordinate):
                    shopCoordinate = coordinate
                case .failure(let error):
                    switch error {
                        case .invalidCoordinate:
                            return completed(.failure(.invalidCoordinate))
                    }
            }
            group.leave()
        }
    
        group.enter()
        getCoordinates(address: customerAddress) {  result in
            switch result {
                case .success(let coordinate):
                    customerCoordinate = coordinate
                case .failure(let error):
                    switch error {
                        case .invalidCoordinate:
                            return completed(.failure(.invalidCoordinate))
                    }
            }
            group.leave()
        }
        
        group.notify(queue: .main){
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
                    let distance = round(route.distance / 1609) //1609 meters per mile
                    if (distance <= self.mileageThreshold){
                        return completed(.success(distance))
                    }else{
                        return completed(.failure(.outsideServiceArea))
                    }
                }
            }
        }
    }
        
    private func getCoordinates(address: String, completion: @escaping (Result<CLLocationCoordinate2D, AddressError>) -> Void){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = (placemark?.location?.coordinate.latitude)
            let long = (placemark?.location?.coordinate.longitude)
            var coordinate = CLLocationCoordinate2D()
            if(lat == nil || long == nil){
                return completion(.failure(.invalidCoordinate))
            }else{
                coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            }
            DispatchQueue.main.async {
                completion(.success(coordinate))
            }
        }
    }
    
}
