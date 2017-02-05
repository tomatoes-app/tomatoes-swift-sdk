//
//  Protocols.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 2/4/17.
//
//

import Foundation

public protocol Deserializable {
    init?(json: [String : Any]?)
}

public protocol Serializable {
    func parameters() -> [String : Any]
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
