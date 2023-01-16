//
//  Restaurant.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import Foundation

struct Restaurant: Codable {
    
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
