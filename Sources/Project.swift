//
//  Project.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Project: Deserializable, Serializable {
    public private(set) var id: String?
    public var name: String?
    public private(set) var tags: [String]?
    public var tagList: String?
    public var moneyBudget: Int?
    public var timeBudget: Int?
    public private(set) var createdAt: Date?
    public private(set) var updatedAt: Date?
 
    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
        name = json?["name"] as? String
        tags = json?["tags"] as? [String]
        moneyBudget = json?["money_budget"] as? Int
        timeBudget = json?["time_budget"] as? Int
        let created = json?["created_at"] as? String
        createdAt = Date.date(from: created, format: Tomatoes.dateFormat)
        let updated = json?["updated_at"] as? String
        updatedAt = Date.date(from: updated, format: Tomatoes.dateFormat)
    }
    
    public init() {}
    
    public func parameters() -> [String : Any] {
        var params = [String: Any]()
        params["name"] = name
        params["tag_list"] = tagList
        params["money_budget"] = moneyBudget
        params["time_budget"] = timeBudget
        return params
    }
    
    public func create(completion: ResponseBlock?) {
        let params = ["project": parameters()]
        Tomatoes.createProject.request(params, completion: completion)
    }
    
    public class func read(id: String, completion: ResponseBlock?) {
        Tomatoes.readProject(id: id).request(completion: completion)
    }
    
    public func update(completion: ResponseBlock?) {
        guard let id = id else {
            completion?(nil, TomatoesError.model("Project id not found."))
            return
        }
        let params = ["project": parameters()]
        Tomatoes.updateProject(id: id).request(params, completion: completion)
    }
    
    public func destroy(completion: ResponseBlock?) {
        guard let id = id else {
            completion?(nil, TomatoesError.model("Project id not found."))
            return
        }
        Tomatoes.destroyProject(id: id).request(self.parameters(), completion: completion)
    }
    
    public class func items(page: UInt, completion: ResponseBlock?) {
        Tomatoes.readProjects(page: page).request(completion: completion)
    }
}
