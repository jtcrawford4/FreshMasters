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
    
    func getDistanceToCustomer(completed: @escaping (Result<Double, FmError>) -> Void){
//    func calcDistanceToCustomer(){
        let group = DispatchGroup()
        let shopAddress = "Jefferson City, MO 65109"
        let customerAddress = "\(self.streetAddress) \(self.city),\(self.state) \(self.zip)"
        var shopCoordinate = CLLocationCoordinate2D()
        var customerCoordinate = CLLocationCoordinate2D()
        
        group.enter()
        getCoordinates(address: shopAddress) {  result in
            switch result {
                case .success(let coordinate):
                    shopCoordinate = coordinate
                case .failure(let error):
                    switch error {
                        case .invalidCoordinate:
                            //MARK: - return errors, modal
                            print("Invalid coordinate")
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
                            print("Invalid coordinate")
                    }
            }
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
//                    self.distanceToCustomer = round(route.distance / 1609)
                    completed(.success(round(route.distance / 1609)))
                }
            }
        }
    }
        
    private func getCoordinates(address: String, completion: @escaping (Result<CLLocationCoordinate2D, AddressError>) -> Void){
        let geocoder = CLGeocoder()
        //MARK: - do try catch
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = (placemark?.location?.coordinate.latitude)
            let long = (placemark?.location?.coordinate.longitude)
            var coordinate = CLLocationCoordinate2D()
            if(lat == nil || long == nil){
                completion(.failure(.invalidCoordinate))
            }else{
                coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
            }
            DispatchQueue.main.async {
                completion(.success(coordinate))
            }
        }
    }
    
}
