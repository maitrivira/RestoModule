//
//  File.swift
//  
//
//  Created by Maitri Vira on 03/07/22.
//

import Core
import RxSwift

public struct GetFavouriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    RestaurantLocaleDataSource.Response == RestaurantModuleEntity,
    Transformer.Response == [RestaurantResponse],
    Transformer.Entity == [RestaurantModuleEntity],
    Transformer.Domain == [RestaurantDomainModel] {
    
        public typealias Request = Any
        public typealias Response = [RestaurantDomainModel]
        
        private let _localeDataSource: RestaurantLocaleDataSource
        private let _mapper: Transformer
        
        public init(
            localeDataSource: RestaurantLocaleDataSource,
            mapper: Transformer){
                
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
    
        public func execute(request: Any?) -> Observable<[RestaurantDomainModel]> {
            return _localeDataSource.getRestaurants()
                .map { _mapper.transformEntityToDomain(entity: $0) }
        }
        
    }
