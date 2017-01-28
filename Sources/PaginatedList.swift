//
//  PaginatedList.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class PaginatedList<T: Deserializable>: Deserializable {
    public var items: [T]?
    public var totalPages: Int?
    public var currentPage: Int?
    public var totalCount: Int?
    
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
