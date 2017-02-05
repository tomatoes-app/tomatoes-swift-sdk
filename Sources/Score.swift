//
//  Score.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public typealias ScoresBlock = (_ result: Result<PaginatedList<Score>>) -> Void

public class Score: Deserializable {
    public private(set) var user: User?
    public private(set) var score: Int?
    
    required public init?(json: [String : Any]?) {
        user = User(json: json?["user"] as? JSONObject)
        score = json?["score"] as? Int
    }
    
    public class func items(period: Period, page: UInt, completion: ScoresBlock?) {
        Tomatoes.readLeaderboard(period: period, page: page).request { (result, error) in
            if let scoresList =  PaginatedList<Score>.init(json: result, root: "scores") {
                completion?(.success(scoresList))
            } else {
                completion?(.failure(error))
            }
        }
    }
}
