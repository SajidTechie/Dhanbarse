//
//  UpdateData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/2/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation

// MARK: - UpdateData
struct CommunicationAddressUpdate: Codable {
    
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[CommunicationAddressObj]?
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
        data = try values.decodeIfPresent([CommunicationAddressObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct CommunicationAddressObj: Codable {
    let userMastId : String?
    let mobileNo : String?
    let userCategoryId : Int?
    
    enum CodingKeys: String, CodingKey {
        case userMastId = "UserMastId"
        case mobileNo = "MobileNo"
        case userCategoryId = "UserCategoryId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userMastId = try values.decodeIfPresent(String.self, forKey: .userMastId)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        userCategoryId = try values.decodeIfPresent(Int.self, forKey: .userCategoryId)
    }
}

