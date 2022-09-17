//
//  File.swift
//  
//
//  Created by Maitri Vira on 03/07/22.
//

import Core
import RxSwift

public struct AddFavouriteRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    RestaurantLocaleDataSource.Request == RestaurantDomainModel,
    RestaurantLocaleDataSource.Response == RestaurantModuleEntity,
    Transformer.Entity == RestaurantModuleEntity,
    Transformer.Domain == RestaurantDomainModel {
     
        public typealias Request = RestaurantDomainModel
        public typealias Response = Bool
        
        private let _localeDataSource: RestaurantLocaleDataSource
        private let _mapper: Transformer
        
        public init(
            localeDataSource: RestaurantLocaleDataSource,
            mapper: Transformer){
                
            _localeDataSource = localeDataSource
            _mapper = mapper
        }
        
        public func execute(request: RestaurantDomainModel?) -> Observable<Bool> {
            return _localeDataSource.addRestaurant(entities: request!)
        }
        
    }
