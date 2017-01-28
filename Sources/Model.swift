//
//  Model.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

protocol Deserializable {
    init?(json: [String : Any]?)
}

extension Deserializable {
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

protocol Serializable {
    func toJSON() -> [String : Any]
}

class User: Deserializable {
    var id: String?
    var name: String?
    
    required init?(json: [String : Any]?) {
        id = json?["id"] as? String
        name = json?["name"] as? String
    }
}

class Tomato: Deserializable {
    var id: String?
    
    required init?(json: [String : Any]?) {
        id = json?["id"] as? String
    }
}

class PaginatedList<T: Deserializable>: Deserializable {
    var items: [T]?
    var totalPages: Int?
    var currentPage: Int?
    var totalCount: Int?
    
    required convenience init?(json: [String : Any]?) {
        self.init(json: json, root: "")
    }
    
    required init?(json: [String : Any]?, root: String) {
        items = T.list(json: json?[root] as? JSONList) as [T]?
        let pagination = json?["pagination"] as? JSONObject
        totalPages = pagination?["total_pages"] as? Int
        currentPage = pagination?["current_page"] as? Int
        totalCount = pagination?["total_count"] as? Int
    }
}

class Project: Deserializable {
    var id: String?
    
    required init?(json: [String : Any]?) {
        id = json?["id"] as? String
    }
}

class Score: Deserializable {
    var user: User?
    var score: Int?
    
    required init?(json: [String : Any]?) {
        user = User(json: json?["user"] as? JSONObject)
        score = json?["score"] as? Int
    }
}
