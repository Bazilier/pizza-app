//
//  RestAPI.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 12.05.2023.
//

import Foundation

// API class to interact with the Dadata API
class API {
    // Singleton instance to allow access to the class methods without creating an instance of the class
    static let shared = API()
    
    // Method to get address suggestions based on a city name
    func getSuggestions(city: String, completion: @escaping (([SuggestAddress]) -> Void)) {
        
        // Create URLComponents object and set scheme, host, and path
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "suggestions.dadata.ru"
        urlComponents.path = "/suggestions/api/4_1/rs/suggest/address"
        
        let url = urlComponents.url!
        let token = "20f31a6d745eea1631ccf2078baa6664989ce41f"
        let secret = "43aafde3b9a7b58d79ae167ac5f1ab37ba543b68"
        let query = "москва \(city)"
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        
        // Set headers for the request
        request.allHTTPHeaderFields = ["Content-type": "application/json",
                                       "Authorization": "Token " + token,
                                       "X-Secret": secret]
        
        do {
            // Preparing the request body with the city query
            let bodyParams: [String: String] = ["query": query]
            let bodyData = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
            // Setting the request body
            request.httpBody = bodyData
        } catch {
            // Printing any error that occurs during JSON serialization
            print(error)
        }
        
        let session = URLSession.init(configuration: .default)
        let decoder = JSONDecoder()
        
        // Creating a data task with the URLRequest
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let bodyData2 = try? JSONSerialization.jsonObject(with: data!, options: [])
            print(response)
            // Making sure there is data to work with
            guard let data = data else { return }
            
            // Decoding the API response
            do {
                // Decoding the data into our model structure
                let addressData = try decoder.decode(SuggestAddresResponse.self, from: data)
                print("Success")
                // If successful, passing the decoded data to the completion closure
                completion(addressData.suggestions)
            } catch {
                // Printing any error that occurs during decoding
                print(error)
            }
        }
        // Starting the data task
        task.resume()
    }
}

