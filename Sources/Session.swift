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
    
    /** Returns true if a Tomatoes token is saved on the keychain  */
   
    public static var isAuthenticated: Bool {
        return KeychainSwift().get(Tomatoes.tokenKey) != nil
    }
    
    /** Creates a new session using a third party auth provider token.
        If a user associated to the access token doesn't exist, a new user will be created.
        The response includes a Tomatoes API token that should be used to perform authenticated requests. */
   
    public func create(completion: ResponseBlock?) {
        Tomatoes.createSession.request(self.parameters(), completion: completion)
    }
    
    /** Deletes all Tomatoes API active sessions for the current user.*/
   
    public func destroy(completion: ResponseBlock?) {
        Tomatoes.destroySession.request(self.parameters(), completion: completion)
    }
}
