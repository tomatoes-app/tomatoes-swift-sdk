//
//  Network.swift
//  Tomatoes
//
//  Created by Giorgia Marenda on 1/22/17.
//  Copyright © 2017 Giorgia Marenda. All rights reserved.
//

import Foundation

public typealias ResponseBlock = (_ result: JSONObject?, _ error: Error?) -> Void

struct Network {
    
    static func serialize(parameters: JSONObject?) -> Data? {
        guard let parameters = parameters else { return nil }
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print("Unable to serialize Objects: \(error)")
            return nil
        }
    }
    
    static func deserialize(data: Data?) -> Any? {
        guard let data = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch let error {
            print("Unable to deserialize JSON: \(error)")
            return nil
        }
    }
    
    static func perfomRequest(_ url: URL, accessToken: String? = nil, parameters: JSONObject? = nil, method: String, completion: (ResponseBlock)?) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        if method == "GET" {
            if let parameters = parameters, !parameters.isEmpty {
                let urlComponents = URLComponents(string: url.absoluteString + Network.query(parameters))
                request.url = urlComponents?.url
            }
        } else {
            request.httpBody = Network.serialize(parameters: parameters)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let accessToken = accessToken {
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                completion?(Network.deserialize(data: data) as? JSONObject, error)
            }
        })
        task.resume()
    }
    
    static func query(_ parameters: JSONObject) -> String {
        return parameters.flatMap { (key, value) -> String in
                return "\(key)=\(value)"
                }.joined(separator: "&")
    }
}
