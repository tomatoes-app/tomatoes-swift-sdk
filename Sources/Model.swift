//
//  Model.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

public typealias JSONObject = [String : Any]
public typealias JSONList = [[String : Any]]

public protocol Deserializable {
    init?(json: [String : Any]?)
}

public extension Deserializable {
    static func list<T: Deserializable>(json: JSONList?) -> [T]? {
        guard let jsonArray = json else { return nil }
        var objectArray = [T]()
        for json in jsonArray {
            if let object = T(json: json) {
                objectArray.append(object)
            }
        }
        return objectArray
    }
}

public protocol Serializable {
    func toJSON() -> [String : Any]
}

public enum Period: String {
    case daily
    case weekly
    case monthly
    case overall
}

public class User: Deserializable {
    var id: String?
    var name: String?
    
    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
        name = json?["name"] as? String
    }
}

public class Tomato: Deserializable {
    var id: String?
    
    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
    }
}

public class PaginatedList<T: Deserializable>: Deserializable {
    var items: [T]?
    var totalPages: Int?
    var currentPage: Int?
    var totalCount: Int?
    
    required public convenience init?(json: [String : Any]?) {
        self.init(json: json, root: "")
    }
    
    required public init?(json: [String : Any]?, root: String) {
        items = T.list(json: json?[root] as? JSONList) as [T]?
        let pagination = json?["pagination"] as? JSONObject
        totalPages = pagination?["total_pages"] as? Int
        currentPage = pagination?["current_page"] as? Int
        totalCount = pagination?["total_count"] as? Int
    }
}

public class Project: Deserializable {
    var id: String?
    
    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
    }
}

public class Score: Deserializable {
    var user: User?
    var score: Int?
    
    required public init?(json: [String : Any]?) {
        user = User(json: json?["user"] as? JSONObject)
        score = json?["score"] as? Int
    }
}
