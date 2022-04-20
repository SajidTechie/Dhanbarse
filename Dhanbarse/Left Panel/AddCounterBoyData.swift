//
//  AddCounterBoyData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/13/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation
struct AddCounterBoyData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[AddCounterBoyObj]?
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
        data = try values.decodeIfPresent([AddCounterBoyObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct AddCounterBoyObj: Codable {
    let headMobileNo: String?
    let counterBoyId: Int?
    let counterBoyCat: Int?
    let headId: Int?
    let headcat: Int?
    
    enum CodingKeys: String, CodingKey {
        case headMobileNo = "HeadMobileNo"
        case counterBoyId = "CounterBoyId"
        case counterBoyCat = "CounterBoyCat"
        case headId = "HeadId"
        case headcat = "Headcat"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headMobileNo = try values.decodeIfPresent(String.self, forKey: .headMobileNo)
        counterBoyId = try values.decodeIfPresent(Int.self, forKey: .counterBoyId)
        counterBoyCat = try values.decodeIfPresent(Int.self, forKey: .counterBoyCat)
        headId = try values.decodeIfPresent(Int.self, forKey: .headId)
        headcat = try values.decodeIfPresent(Int.self, forKey: .headcat)
    }
}

