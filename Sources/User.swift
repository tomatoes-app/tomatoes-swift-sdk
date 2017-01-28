//
//  User.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 1/28/17.
//
//

import Foundation

public class User: Deserializable {
    public var id: String?
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
    public var currencyUnit: String?
    public var tomatoesCounters: Counter?
    public var authorizations: [Authorization]?
    public var createdAt: Date?
    public var updatedAt: Date?

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
}
