//
//  Common.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

public typealias ResultBlock<T> = (_ result: Result<T>) -> Void
public typealias EmptyResultBlock = (_ result: EmptyResult) -> Void
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

public enum EmptyResult {
    case success
    case failure(Error?)
}

func responseBlock<T: Deserializable>(_ completion: ResultBlock<T>?) -> ResponseBlock {
    return { (result, error) in
        if let tomato = T(json: result) {
            completion?(.success(tomato))
        } else {
            completion?(.failure(error))
        }
    }
}
