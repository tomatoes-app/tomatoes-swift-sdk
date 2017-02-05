//
//  Tomato.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public typealias TomatoBlock = (_ result: Result<Tomato>) -> Void
public typealias TomatoesBlock = (_ result: Result<PaginatedList<Tomato>>) -> Void

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
   
    class func responseBlock(_ completion: TomatoBlock?) -> ResponseBlock {
        return { (result, error) in
            if let tomato = Tomato(json: result) {
                completion?(.success(tomato))
            }
            completion?(.failure(error))
        }
    }
    
    public func create(completion: TomatoBlock?) {
        let params = ["tomato": parameters()]
        Tomatoes.createTomato.request(params, completion: Tomato.responseBlock(completion))
    }
    
    public class func read(id: String, completion: TomatoBlock?) {
        Tomatoes.readTomato(id: id).request(completion: Tomato.responseBlock(completion))
    }
    
    public func update(completion: TomatoBlock?) {
        guard let id = id else {
            completion?(.failure(TomatoesError.model("Tomato id not found.")))
            return
        }
        let params = ["tomato": parameters()]
        Tomatoes.updateTomato(id: id).request(params, completion: Tomato.responseBlock(completion))
    }
    
    public func destroy(completion: SuccessBlock?) {
        guard let id = id else {
            completion?(.failure(TomatoesError.model("Tomato id not found.")))
            return
        }
        Tomatoes.destroyTomato(id: id).request(self.parameters()) { (_, error) in
            if let error = error {
                completion?(.failure(error))
            }
            completion?(.success(true))
        }
    }
    
    public class func items(page: UInt, completion: TomatoesBlock?) {
        Tomatoes.readTomatoes(page: page).request  { (result, error) in
            if let tomatoesList =  PaginatedList<Tomato>.init(json: result, root: "tomatoes") {
                completion?(.success(tomatoesList))
            }
            completion?(.failure(error))
        }
    }
    
}
