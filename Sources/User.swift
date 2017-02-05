//
//  User.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public typealias UserBlock = (_ result: Result<User>) -> Void

public class User: Deserializable, Serializable {
    public private(set) var id: String?
    public var name: String?
    public var email: String?
    public var image: String?
    public var timezone: String?
    public var color: String?
    public var volume: Int? // 0...3
    public var ticking: Bool?
    public var workHoursPerDay: Int?
    public var averageHourlyRate: Int?
    public var currency: String?
    public private(set) var currencyUnit: String?
    public private(set) var tomatoesCounters: Counter?
    public private(set) var authorizations: [Authorization]?
    public private(set) var createdAt: Date?
    public private(set) var updatedAt: Date?

    public init() {}
    
    required public init?(json: [String : Any]?) {
        id = json?["id"] as? String
        name = json?["name"] as? String
        email = json?["email"] as? String
        image = json?["image"] as? String
        timezone = json?["timezone"] as? String
        volume = json?["volume"] as? Int
        ticking = json?["ticking"] as? Bool
        workHoursPerDay = json?["work_hours_per_day"] as? Int
        averageHourlyRate = json?["average_hourly_rate"] as? Int
        currency = json?["currency"] as? String
        currencyUnit = json?["currency_unit"] as? String
        tomatoesCounters = Counter(json: json?["tomatoes_counters"] as? JSONObject)
        authorizations = Authorization.list(json: json?["authorizations"] as? JSONList) as [Authorization]?
        let created = json?["created_at"] as? String
        createdAt = Date.date(from: created, format: Tomatoes.dateFormat)
        let updated = json?["updated_at"] as? String
        updatedAt = Date.date(from: updated, format: Tomatoes.dateFormat)
    }
    
    public func parameters() -> [String : Any] {
        var params = [String: Any]()
        params["name"] = name
        params["email"] = email
        params["image"] = image
        params["time_zone"] = timezone
        params["color"] = color
        params["work_hours_per_day"] = workHoursPerDay
        params["average_hourly_rate"] = averageHourlyRate
        params["currency"] = currency
        params["volume"] = volume
        params["ticking"] = ticking
        return params
    }
    
    public class func read(completion: UserBlock?) {
        Tomatoes.readUser.request { (result, error) in
            if let user = User(json: result) {
                completion?(.success(user))
            }
            completion?(.failure(error))
        }
    }
    
    public func update(completion: UserBlock?) {
        let params = ["user": parameters()]
        Tomatoes.updateUser.request(params) { (result, error) in
            if let user = User(json: result) {
                completion?(.success(user))
            }
            completion?(.failure(error))
        }
    }
}

