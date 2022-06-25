//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Foundation

public struct RestaurantDomainModel: Equatable, Identifiable {
    
    public let id: String
    public let name: String
    public let descriptions: String
    public let pictureId: String
    public let city: String
    public let rating: Double
    
}
