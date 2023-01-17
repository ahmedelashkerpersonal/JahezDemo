//
//  Restaurant.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

struct RestaurantWithImage: Hashable {
    let restaurant: Restaurant
    let image: UIImage?
}

struct Restaurant: Codable, Hashable {
    
    let id: Int
    let name: String
    let description: String
    let hours: String
    let image: String
    let rating: Double
    let distance: Double
    let hasOffer: Bool
    let offer: String?
    
}
