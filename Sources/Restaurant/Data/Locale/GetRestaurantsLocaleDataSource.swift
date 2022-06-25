//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Core
import RxSwift
import RealmSwift
import Foundation

public struct GetRestaurantsLocaleDataSource: LocaleDataSource {
    
    public typealias Request = Any
    public typealias Response = RestaurantModuleEntity

    private let _realm: Realm?
    public init(realm: Realm?) {
        _realm = realm
    }
    
    public func list(request: Any?) -> Observable<[RestaurantModuleEntity]> {
        return Observable<[RestaurantModuleEntity]>.create { observer in
            
            if let realm = self._realm {
                let restaurants: Results<RestaurantModuleEntity> = {
                    realm.objects(RestaurantModuleEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                observer.onNext(restaurants.toArray(ofType: RestaurantModuleEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
            
        }
    }
    
    public func add(entities: RestaurantModuleEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm{
                do {
                    try realm.write {
                        realm.add(entities, update: .all)
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
    
    public func get(request id: String) -> Observable<RestaurantModuleEntity> {
        fatalError()
    }
    
    public func delete(request data: RestaurantModuleEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm{
                do {
                    try realm.write {
                        realm.delete(realm.objects(RestaurantModuleEntity.self).filter("id=%@", data.id))
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()
        }
    }
}
