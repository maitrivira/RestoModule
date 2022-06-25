//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Core
import RxSwift
import Alamofire
import Foundation

public struct RemoteDataSource: DataSource {
    
    public typealias Request = String
    public typealias Response = [RestaurantResponse]
    
    private let _endpoint: String
    public init(endpoint: String) {
        _endpoint = endpoint
    }
    
    public func getRestaurants(request: Request?) -> Observable<[RestaurantResponse]> {
        return Observable<[RestaurantResponse]>.create { observer in
            
            var urls = _endpoint
            
            if let request = request {
                let newRequest = request.replacingOccurrences(of: " ", with: "%20")
                urls = _endpoint + newRequest
            }
            
            if let url = URL(string: urls) {
                AF.request(url,encoding: URLEncoding.httpBody)
                    .validate()
                    .responseDecodable(of: RestaurantsResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            print("success get restaurants module")
                            observer.onNext(value.restaurants)
                            observer.onCompleted()
                        case .failure:
                            print("failure")
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
}
