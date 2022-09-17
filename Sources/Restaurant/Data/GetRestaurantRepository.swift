//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Core
import RxSwift

public struct GetRestaurantRepository<
    RestaurantLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where

    RestaurantLocaleDataSource.Response == RestaurantModuleEntity,
    RemoteDataSource.Response == [RestaurantResponse],
    Transformer.Response == [RestaurantResponse],
    Transformer.Entity == [RestaurantModuleEntity],
    Transformer.Domain == [RestaurantDomainModel] {
    
    public typealias Request = Any
    public typealias Response = [RestaurantDomainModel]

    private let _localeDataSource: RestaurantLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: RestaurantLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer){

        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }
    
    public func execute(request: Any?) -> Observable<[RestaurantDomainModel]> {
        return _remoteDataSource.getRestaurants(request: nil)
            .map { _mapper.transformResponseToDomain(response: $0) }
    }
    
}
