//
//  NetworkManager.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

struct NetworkManager {
    
    fileprivate let restaurantsPath = "https://jahez-other-oniiphi8.s3.eu-central-1.amazonaws.com/restaurants.json"
    
    func loadRestaurants() async throws -> [Restaurant] {
        
        guard let url = URL(string: self.restaurantsPath) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        do {
            let restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
            print(restaurants)
            return restaurants
        } catch let error {
            print(error)
            throw NetworkError.invalidData
        }
        
    }
    
    func loadImage(urlString: String) async throws -> UIImage? {
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            return nil
        }
        
        let image = UIImage(data: data)
        return image
        
    }
    
}
