//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Foundation

public struct RestaurantsResponse: Decodable {
    
    let restaurants: [RestaurantResponse]
    
}

public struct RestaurantResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name, pictureId, city, rating
        case descriptions = "description"
    }
    
    let id: String?
    let name: String?
    let descriptions: String?
    let pictureId: String?
    let city: String?
    let rating: Double?
    
}
