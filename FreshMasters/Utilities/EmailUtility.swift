//
//  EmailUtility.swift
//  FreshMasters
//
//  Created by John Crawford on 4/6/21.
//

import Foundation

func sendEmail(customer: Customer, vehicle: Vehicle, completed: @escaping (Result<Bool, EmailError>) -> Void){
    let semaphore = DispatchSemaphore (value: 0)
    let customerText = getCustomerText(customer: customer)
    let vehicleText  = getVehicleText(vehicle: vehicle)
    let text = "\(customerText)\n\n\(vehicleText)"
    let apiKey = Bundle.main.object(forInfoDictionaryKey:"MAILGUN_API") as! String
    let id = Bundle.main.object(forInfoDictionaryKey:"MAILGUN_ID") as! String
    let receiverEmail = Bundle.main.object(forInfoDictionaryKey:"MAILGUN_RECEIVER") as! String
    
    if(apiKey == "" || id == "" || receiverEmail == ""){
        completed(.failure(EmailError.emailFailure))
        return
    }
    
    let url = "https://api:\(apiKey)@api.mailgun.net/v3/\(id)/messages"
    let parameters = "from= FreshMasters <mailgun@\(id)>&to=\(receiverEmail)&subject=Detailing Apopintment&text=\(text)"
    let postData =  parameters.data(using: .utf8)
    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        completed(.failure(EmailError.emailFailure))
        semaphore.signal()
        return
      }
        
        if let httpResponse = response as? HTTPURLResponse{
            if httpResponse.statusCode == 200{
                print(String(data: data, encoding: .utf8)!)
                completed(.success(true))
                semaphore.signal()
                return
            }
            else{
                completed(.failure(EmailError.emailFailure))
                semaphore.signal()
                return
            }
        }
    }
    
    task.resume()
    semaphore.wait()
}

private func getCustomerText(customer: Customer) -> String {
    return """
        Name: \(customer.firstName) \(customer.lastName)
        Address: \(customer.address.city) \(customer.address.state) \(customer.address.zip)
        Phone: \(customer.phone)
        Email: \(customer.email)
        Appt Date: \(customer.appointmentDate)
        Contact Text: \(customer.contactByText)
        Contact Phone: \(customer.contactByPhone)
        Contact Email: \(customer.contactByEmail)
    """
}

private func getVehicleText(vehicle: Vehicle) -> String{
    return """
        Vehicle: \(vehicle.getYearMakeModel())
        Service Type: \(vehicle.serviceType)
        Price: $\(vehicle.getTotalPrice())
        Hours: \(vehicle.hours.getTotalHoursLow()) - \(vehicle.hours.getTotalHoursHigh())
        Polish: \(vehicle.polish)
        Headlight Restoration: \(vehicle.headlightRestore)
        Glaze: \(vehicle.glaze)
        Engine Detail: \(vehicle.engine)
        Mobile Service: \(vehicle.mobileService)
        Age Surcharge: \(vehicle.hasAgeSurcharge)
    """
}
