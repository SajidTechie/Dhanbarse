//
//  GetCounterBoyList.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/2/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation

// MARK: - GetCounterBoy
struct GetCounterBoyElement: Codable {
    
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[CounterBoyObj]?
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
        data = try values.decodeIfPresent([CounterBoyObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

// MARK: - Datum
struct CounterBoyObj: Codable {
    let userName: String?
    let mobileNo: String?
    let status: String?
    let slNo: Int?
    
    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case mobileNo = "MobileNo"
        case status = "Status"
        case slNo = "SlNo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
    }
}

