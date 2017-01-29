//
//  PaginatedList.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class PaginatedList<T: Deserializable>: Deserializable {
    public private(set) var items: [T]?
    public private(set) var totalPages: Int?
    public private(set) var currentPage: Int?
    public private(set) var totalCount: Int?
    
    public required init() {}
    
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
