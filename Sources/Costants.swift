//
//  Costants.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

public typealias SuccessBlock = (_ result: Result<Bool>) -> Void
public typealias JSONObject = [String : Any]
public typealias JSONList = [[String : Any]]

public enum Provider: String {
    case github
    case twitter
}

public enum Period: String {
    case daily
    case weekly
    case monthly
    case overall
}

public enum Result<T> {
    case success(T)
    case failure(Error?)
}
