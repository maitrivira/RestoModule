//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Core
import RxSwift

public struct GetSearchRestaurantsRepository<
    RestaurantRemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    RestaurantRemoteDataSource.Request == String,
    RestaurantRemoteDataSource.Response == [RestaurantResponse],
    Transformer.Response == [RestaurantResponse],
    Transformer.Entity == [RestaurantModuleEntity],
    Transformer.Domain == [RestaurantDomainModel] {
        
        public typealias Request = String
        public typealias Response = [RestaurantDomainModel]
        
        private let _remoteDataSource: RestaurantRemoteDataSource
        private let _mapper: Transformer
        
        public init(
            remoteDataSource: RestaurantRemoteDataSource,
            mapper: Transformer){
                
                _remoteDataSource = remoteDataSource
                _mapper = mapper
                
            }

        public func execute(request: String?) -> Observable<[RestaurantDomainModel]> {
            return _remoteDataSource.getRestaurants(request: request)
                .map { _mapper.transformResponseToDomain(response: $0) }
        }
        
    }
