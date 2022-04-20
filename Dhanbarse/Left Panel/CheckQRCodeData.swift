//
//  CheckQRCodeData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/28/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct CheckQrCodeData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data: [CheckQrCodeObj]?
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
        data = try values.decodeIfPresent([CheckQrCodeObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct CheckQrCodeObj: Codable {
    let statusCode: Int?
    let statusCodeMessage: String?
    
    enum CodingKeys: String, CodingKey {
           case statusCode = "StatusCode"
           case statusCodeMessage = "StatusCodeMessage"
       }
       
       init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
           statusCodeMessage = try values.decodeIfPresent(String.self, forKey: .statusCodeMessage)
       }
}
