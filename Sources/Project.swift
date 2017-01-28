//
//  Project.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Project: Deserializable {
    public var id: String?
    public var name: String?
    public var tags: [String]?
    public var moneyBudget: Int?
    public var timeBudget: Int?
    public var createdAt: Date?
    public var updatedAt: Date?
 
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
}
