//
//  DashboardData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/25/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//


import Foundation
struct DashboardPointsData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[DashboardPointsObj]?
    let errors: [ErrorData]?
    
    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case statusCode = "StatusCode"
        case statusCodeMessage = "StatusCodeMessage"
        case timestamp = "Timestamp"
        case size = "Size"
        case data = "Data"
        case errors = "Errors"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        version = try values.decodeIfPresent(String.self, forKey: .version)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusCodeMessage = try values.decodeIfPresent(String.self, forKey: .statusCodeMessage)
        timestamp = try values.decodeIfPresent(String.self, forKey: .timestamp)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
        data = try values.decodeIfPresent([DashboardPointsObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct DashboardPointsObj: Codable {
    let retailerPoints : Double?
    let dealerPoints : Double?
  
    enum CodingKeys: String, CodingKey {
        case retailerPoints = "RRP"
        case dealerPoints = "DRP"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retailerPoints = try values.decodeIfPresent(Double.self, forKey: .retailerPoints)
        dealerPoints = try values.decodeIfPresent(Double.self, forKey: .dealerPoints)
    }
}


