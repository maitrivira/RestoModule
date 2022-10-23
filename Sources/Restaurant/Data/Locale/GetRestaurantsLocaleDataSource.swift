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
    
    public typealias Request = RestaurantDomainModel
    public typealias Response = RestaurantModuleEntity

    private let _realm: Realm?
    private let _mapper = RestaurantTransformer()
    
    public init(realm: Realm?) {
        _realm = realm
    }
    
    public func getRestaurants() -> Observable<[RestaurantModuleEntity]> {
        print("masuk resto locale data source")
        return Observable<[RestaurantModuleEntity]>.create { observer in

            if let realm = self._realm {
                let restaurants: Results<RestaurantModuleEntity> = {
                    realm.objects(RestaurantModuleEntity.self)
                        .sorted(byKeyPath: "id", ascending: true)
                }()
                observer.onNext(restaurants.toArray(ofType: RestaurantModuleEntity.self))
                print("data resto", restaurants)
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.requestFailed)
            }
            return Disposables.create()

        }
    }
    
    public func getRestaurant(request id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let localDatabase = self._realm {
            do {
              let getObjectById = localDatabase.objects(RestaurantModuleEntity.self).filter("id == %@", id).first

              if getObjectById != nil {
                observer.onNext(true)
              } else {
                observer.onNext(false)
              }

              observer.onCompleted()
            }
          } else {
            observer.onError(DatabaseError.requestFailed)
            print(DatabaseError.requestFailed)
          }
          return Disposables.create()
        }
    }
    
    public func addRestaurant(entities: RestaurantDomainModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let localDatabase = self._realm {
            do {
                let getObjectById = localDatabase.objects(RestaurantModuleEntity.self).filter("id == %@", entities).first

                if let getObjectById = getObjectById {
                    if getObjectById != nil {
                      try localDatabase.write {
                        localDatabase.delete(getObjectById)

                        observer.onNext(true)
                        observer.onCompleted()
                        print("data has beeen deleted to local DB")
                      }
                    } else {
                      try localDatabase.write {
                        localDatabase.add(getObjectById)

                        observer.onNext(true)
                        observer.onCompleted()
                        print("data has beeen saved to local DB")
                        print(entities)
                      }
                    }
                }

            } catch {
              observer.onError(DatabaseError.requestFailed)
              print(DatabaseError.requestFailed)
            }
          } else {
            observer.onError(DatabaseError.requestFailed)
            print(DatabaseError.requestFailed)
          }
          return Disposables.create()
        }
    }
    
    public func removeRestaurant(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self._realm{
                do {
                    try realm.write {
                        realm.delete(realm.objects(RestaurantModuleEntity.self).filter("id=%@", id))
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
