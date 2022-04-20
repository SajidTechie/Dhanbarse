//
//  SendOtp.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/13/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation
struct SendOtpElement: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[SendOtpObj]?
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
        data = try values.decodeIfPresent([SendOtpObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct SendOtpObj: Codable {
    let mobileNo: String?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
           case mobileNo = "Mobile"
           case message = "Message"
       }

       init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
           message = try values.decodeIfPresent(String.self, forKey: .message)
       }
}
