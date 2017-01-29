//
//  Error.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/29/17.
//
//

import Foundation

public enum TomatoesError: Error {
    case model(String)
    
    var localizedDescription: String {
        switch self {
        case .model(let message): return message
        }
    }
}
