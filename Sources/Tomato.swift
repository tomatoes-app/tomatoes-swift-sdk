//
//  Tomato.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Tomato: Deserializable, Serializable {
    public private(set) var id: String?
    public private(set) var tags: [String]?
    public var tagList: String?
    public private(set) var createdAt: Date?
    public private(set) var updatedAt: Date?

    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
        tags = json?["tags"] as? [String]
        let created = json?["created_at"] as? String
        createdAt = Date.date(from: created, format: Tomatoes.dateFormat)
        let updated = json?["updated_at"] as? String
        updatedAt = Date.date(from: updated, format: Tomatoes.dateFormat)
    }
    
    public init() {}
    
    public func parameters() -> [String : Any] {
        var params = [String: Any]()
        params["tag_list"] = tagList
        return params
    }
    
    public func create(completion: ResponseBlock?) {
        let params = ["tomato": parameters()]
        Tomatoes.createTomato.request(params, completion: completion)
    }
    
    public class func read(id: String, completion: ResponseBlock?) {
        Tomatoes.readTomato(id: id).request(completion: completion)
    }
    
    public func update(completion: ResponseBlock?) {
        guard let id = id else {
            completion?(nil, TomatoesError.model("Tomato id not found."))
            return
        }
        let params = ["tomato": parameters()]
        Tomatoes.updateTomato(id: id).request(params, completion: completion)
    }
    
    public func destroy(completion: ResponseBlock?) {
        guard let id = id else {
            completion?(nil, TomatoesError.model("Tomato id not found."))
            return
        }
        Tomatoes.destroyTomato(id: id).request(self.parameters(), completion: completion)
    }
    
    public class func items(page: UInt, completion: ResponseBlock?) {
        Tomatoes.readTomatoes(page: page).request(completion: completion)
    }
    
}
