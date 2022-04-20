//
//  RegisterComplaintData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 8/27/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct RegisterComplaintData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data: [RegisterComplaintObj]?
    let errors: [ErrorDataComplaint]?
    
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
        data = try values.decodeIfPresent([RegisterComplaintObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorDataComplaint].self, forKey: .errors)
    }
}

struct RegisterComplaintObj: Codable {
   let statusCode: Int?
   let statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
           case statusCode = "ComplaintNumber"
           case statusMessage = "StatusMessage"
       }
       
       init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
           statusMessage = try values.decodeIfPresent(String.self, forKey: .statusMessage)
       }
}

struct ErrorDataComplaint : Codable {
    let errorCode : Int?
    let errorMsg : String?
    let parameter : String?
    let helpUrl : String?

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case errorMsg = "ErrorMsg"
        case parameter = "Parameter"
        case helpUrl = "HelpUrl"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorCode = try values.decodeIfPresent(Int.self, forKey: .errorCode)
        errorMsg = try values.decodeIfPresent(String.self, forKey: .errorMsg)
        parameter = try values.decodeIfPresent(String.self, forKey: .parameter)
        helpUrl = try values.decodeIfPresent(String.self, forKey: .helpUrl)
    }

}
