//
//  EmailUtility.swift
//  FreshMasters
//
//  Created by John Crawford on 4/6/21.
//

import Foundation

func sendEmail(){
    let semaphore = DispatchSemaphore (value: 0)
    //MARK: - error if nil. guard let xyz...
    let apiKey = Bundle.main.object(forInfoDictionaryKey:"MAILGUN_API") as! String
    let id = Bundle.main.object(forInfoDictionaryKey:"MAILGUN_ID") as! String
    let url = "https://api:\(apiKey)@api.mailgun.net/v3/\(id)/messages"
    //MARK: - receiver email plist
    let parameters = "from= Swift Email <mailgun@\(id)>&to=drivingfresh@gmail.com&subject=Hello&text=Testing_some_Mailgun_awesomness"
    let postData =  parameters.data(using: .utf8)
    var request = URLRequest(url: URL(string: url)!,timeoutInterval: Double.infinity)
    
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        semaphore.signal()
        return
      }
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()
}

extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
