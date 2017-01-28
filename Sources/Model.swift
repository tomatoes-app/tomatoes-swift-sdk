//
//  Model.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

public typealias JSONObject = [String : Any]
public typealias JSONList = [[String : Any]]

public protocol Deserializable {
    init?(json: [String : Any]?)
}

public protocol Serializable {
    func parameters() -> [String : Any]
}

public enum Provider: String {
    case github
}

public enum Period: String {
    case daily
    case weekly
    case monthly
    case overall
}

public extension Deserializable {
    static func list<T: Deserializable>(json: JSONList?) -> [T]? {
        guard let jsonArray = json else { return nil }
        var objectArray = [T]()
        for json in jsonArray {
            if let object = T(json: json) {
                objectArray.append(object)
            }
        }
        return objectArray
    }
}
