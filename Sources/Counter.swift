//
//  Counter.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Counter: Deserializable {
    public var day: Int?
    public var week: Int?
    public var month: Int?
    
    required public init?(json: [String : Any]?) {
        day = json?["day"] as? Int
        week = json?["week"] as? Int
        month = json?["week"] as? Int
    }
}
