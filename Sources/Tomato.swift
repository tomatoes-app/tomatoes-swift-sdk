//
//  Tomato.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Tomato: Deserializable {
    public var id: String?
    public var tags: [String]?
    public var createdAt: Date?
    public var updatedAt: Date?

    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
        tags = json?["tags"] as? [String]
        let created = json?["created_at"] as? String
        createdAt = Date.date(from: created, format: Tomatoes.dateFormat)
        let updated = json?["updated_at"] as? String
        updatedAt = Date.date(from: updated, format: Tomatoes.dateFormat)
    }
}
