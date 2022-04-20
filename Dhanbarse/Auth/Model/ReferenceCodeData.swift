//
//  ReferenceCodeData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/9/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct ReferenceCodeData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[ReferenceCodeObj]?
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
        data = try values.decodeIfPresent([ReferenceCodeObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct ReferenceCodeObj: Codable {
    
    let categoryName: String?
    let userName: String?
    let mobileNo: String?
    let email: String?
    let slNo: Int?
    let userCategoryId: Int?
    
    enum CodingKeys: String, CodingKey {
        case slNo = "SlNo"
        case userCategoryId = "UserCategoryId"
        case categoryName = "Categorynm"
        case userName = "UserName"
        case mobileNo = "MobileNo"
        case email = "Email"
       }

       init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
        userCategoryId = try values.decodeIfPresent(Int.self, forKey: .userCategoryId)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
           
       }
}
