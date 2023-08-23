//
//  BannerAPIClient.swift
//  PizzaApp
//
//  Created by Кирилл Васильев on 22.04.2023.
//

import Foundation

class BannerAPIClient {
    
    let session = URLSession.init(configuration: .default)
    
    func fetchBanner(completion: @escaping ([Banner]) -> ()) {
        let baseUrl = URLConfigurator(.banners).baseUrl
        let urlComponents = URLComponents.init(string: baseUrl)
        
        guard let url = urlComponents?.url else { return }
        print(url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200..<300:
                    print("Success Status \(response.statusCode)")
                    break
                default:
                    print("Status: \(response.statusCode)")
                }
            }
            guard let data = data else { return }
            let decoder = JSONDecoder.init()
            
            do {
                let jsonModel = try decoder.decode(BannerResponse.self, from: data)
                DispatchQueue.main.async {
                    print(Thread.current)
                    completion(jsonModel.banners)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
}
