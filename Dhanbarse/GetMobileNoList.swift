//
//  GetMobileNoList.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/3/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation

struct GetMobileNoElement: Codable {
    
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[MobileNoObj]?
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
        data = try values.decodeIfPresent([MobileNoObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

// MARK: - Datum
struct MobileNoObj: Codable {
    let slNo: Int?
    let ownerName: String?
    let mobileNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case slNo = "SlNo"
        case ownerName = "OwnerName"
        case mobileNumber = "PrimaryMobileNo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
        ownerName = try values.decodeIfPresent(String.self, forKey: .ownerName)
        mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
    }
}

