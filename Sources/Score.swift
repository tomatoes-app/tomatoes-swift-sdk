//
//  Score.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Score: Deserializable {
    public var user: User?
    public var score: Int?
    
    required public init?(json: [String : Any]?) {
        user = User(json: json?["user"] as? JSONObject)
        score = json?["score"] as? Int
    }
}
