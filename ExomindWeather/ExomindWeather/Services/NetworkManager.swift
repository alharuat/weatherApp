//
//  NetworkManager.swift
//  ExomindWeather
//
//  Created by Samir on 4/3/23.
//

import Foundation
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeather(lat: Double?, lon: Double?, completion: @escaping (WeatherResponse?) -> ()) {
        let stringURL = "\(Config.baseUrl)?lat=\(lat ?? 0)&lon=\(lon ?? 0)&appid=\(Config.apiKey)&units=\(UnitsNotation.metric)"
        print(stringURL)
        guard let url = URL(string: stringURL) else { completion(nil); return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let weatherResponse = try decoder.decode(WeatherResponse.self , from: data)
                
                print("data  \(data)")
                
                DispatchQueue.main.async {
                    completion(weatherResponse)
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(nil)
                }
                print(error.localizedDescription)
            }
        }.resume()
    }
}
