//
//  Session.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class Session: Serializable {
    public var provider: Provider
    public var accessToken: String
    
    public required init(provider: Provider, accessToken: String) {
        self.provider = provider
        self.accessToken = accessToken
    }
    
    public func parameters() -> [String : Any] {
        return ["provider": provider.rawValue,
                "access_token": accessToken]
    }
}
