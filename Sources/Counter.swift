//
//  Counter.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Counter: Deserializable {
    public private(set) var day: Int?
    public private(set) var week: Int?
    public private(set) var month: Int?
    
    required public init?(json: [String : Any]?) {
        day = json?["day"] as? Int
        week = json?["week"] as? Int
        month = json?["month"] as? Int
    }
}
