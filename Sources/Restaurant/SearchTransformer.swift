//
//  File.swift
//  
//
//  Created by Maitri Vira on 25/05/22.
//

import Core

public struct SearchTransformer: Mapper {
    
    
    
    public typealias Request = [RestaurantDomainModel]
    public typealias Response = [RestaurantResponse]
    public typealias Entity = [RestaurantModuleEntity]
    public typealias Domain = [RestaurantDomainModel]
    
    public init() {}
    
    public func transformResponseToEntity(response: [RestaurantResponse]) -> [RestaurantModuleEntity] {
        return response.map { result in
            let newRestaurant = RestaurantModuleEntity()
            newRestaurant.id = result.id ?? ""
            newRestaurant.name = result.name ?? ""
            newRestaurant.descriptions = result.descriptions ?? ""
            newRestaurant.pictureId = result.pictureId ?? ""
            newRestaurant.city = result.city ?? ""
            newRestaurant.rating = result.rating ?? 0.0
            return newRestaurant
        }
    }
    
    public func transformModelToEntity(request: [RestaurantDomainModel]) -> [RestaurantModuleEntity] {
        return request.map { result in
            let newRestaurant = RestaurantModuleEntity()
            newRestaurant.id = result.id
            newRestaurant.name = result.name
            newRestaurant.descriptions = result.descriptions
            newRestaurant.pictureId = result.pictureId
            newRestaurant.city = result.city
            newRestaurant.rating = result.rating
            return newRestaurant
        }
    }
    
    public func transformEntityToDomain(entity: [RestaurantModuleEntity]) -> [RestaurantDomainModel] {
        return entity.map { result in
            return RestaurantDomainModel(
                id: result.id,
                name: result.name,
                descriptions: result.descriptions,
                pictureId: result.city,
                city: result.city,
                rating: result.rating
            )
        }
    }
    
    public func transformResponseToDomain(response: [RestaurantResponse]) -> [RestaurantDomainModel] {
        return response.map { result in
            return RestaurantDomainModel(
                id: result.id ?? "",
                name: result.name ?? "",
                descriptions: result.descriptions ?? "",
                pictureId: result.pictureId ?? "",
                city: result.city ?? "",
                rating: result.rating ?? 0.0)
        }
    }
    
    public func transformDomainToEntity(domain: [RestaurantDomainModel]) -> [RestaurantModuleEntity] {
        return domain.map { result in
            let newRestaurant = RestaurantModuleEntity()
            newRestaurant.id = result.id
            newRestaurant.name = result.name
            newRestaurant.descriptions = result.descriptions
            newRestaurant.pictureId = result.pictureId
            newRestaurant.city = result.city
            newRestaurant.rating = result.rating
            return newRestaurant
        }
    }
    
}
