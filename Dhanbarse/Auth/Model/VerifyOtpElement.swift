//
//  VerifyOtp.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/13/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation
struct VerifyOtpElement: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data: [VerifyOtpObj]?
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
           data = try values.decodeIfPresent([VerifyOtpObj].self, forKey: .data)
           errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
       }
}

struct VerifyOtpObj: Codable {
       let username: String?
       let userid: Int?
       let usercat: Int?
       let password: Int?
       let slNo: Int?
       let profileStatus: Int?
       let isAssistant: Bool?
    
    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case userid = "USERID"
        case usercat = "Usercat"
        case password = "Password"
        case slNo = "SlNo"
        case profileStatus = "ProfileStatus"
        case isAssistant = "ISAssistant"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        userid = try values.decodeIfPresent(Int.self, forKey: .userid)
        usercat = try values.decodeIfPresent(Int.self, forKey: .usercat)
        password = try values.decodeIfPresent(Int.self, forKey: .password)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
        profileStatus = try values.decodeIfPresent(Int.self, forKey: .profileStatus)
        isAssistant = try values.decodeIfPresent(Bool.self, forKey: .isAssistant)
    }
}
