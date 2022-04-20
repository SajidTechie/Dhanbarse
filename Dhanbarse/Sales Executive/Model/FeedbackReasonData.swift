//
//  FeedbackListData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 7/16/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct FeedbackReasonData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data: [FeedbackReasonObj]?
    let errors: [ErrorFeedbackList]?
    
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
        data = try values.decodeIfPresent([FeedbackReasonObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorFeedbackList].self, forKey: .errors)
    }
}

struct FeedbackReasonObj: Codable {
    let slNo : Int?
    let feedbackReason : String?

    enum CodingKeys: String, CodingKey {
        case slNo = "SlNo"
        case feedbackReason = "FeedbackReason"
    }
   
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
        feedbackReason = try values.decodeIfPresent(String.self, forKey: .feedbackReason)
    }
}

struct ErrorFeedbackList : Codable {
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
