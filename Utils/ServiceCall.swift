//
//  ServiceCall.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 16/08/2024.
//

import SwiftUI

class ServiceCall {
    class func post(parameter: Codable, path: String, withSuccess: @escaping ( (_ responseObj: Data?) ->() ), failure: @escaping ( (_ error: Error?) ->() ) ) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let jsonData = try? JSONEncoder().encode(parameter)
            var request = URLRequest(url: URL(string: path)!,timeoutInterval: 20)
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue(Utils.currentMilliseconds(), forHTTPHeaderField: "timestamp")
            request.httpMethod = "POST"
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
                if let data = data {
                    DispatchQueue.main.async {
                        withSuccess(data)
                    }
                }
            }
            task.resume()
        }
    }
}
