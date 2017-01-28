//
//  Authorization.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Authorization: Deserializable {
    public var provider: Provider?
    public var uid: String?
    public var nickname: String?
    public var image: String?
    
    required public init?(json: [String : Any]?) {
        let providerString = json?["provider"] as? String ?? ""
        provider = Provider(rawValue: providerString)
        uid = json?["uid"] as? String
        nickname = json?["nickname"] as? String
        image = json?["image"] as? String
    }
}
