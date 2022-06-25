//
//  File.swift
//  
//
//  Created by Maitri Vira on 20/05/22.
//

import Foundation
import RealmSwift

public class RestaurantModuleEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var pictureId: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var rating: Double = 0.0
    
    public override static func primaryKey() -> String? {
        return "id"
    }
    
}
