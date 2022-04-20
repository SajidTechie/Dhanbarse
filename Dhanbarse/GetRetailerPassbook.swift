//
//  GetRetailerPassbook.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/24/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct RetailerPassbookData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[RetailerPassbookObj]?
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
        data = try values.decodeIfPresent([RetailerPassbookObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}


struct RetailerPassbookObj: Codable {
    let points : Int?
    let transferFrom : String?
    let transferTo : String?
    let transactiondt : String?
    let transtype : String?
    let documentName : String?
  
    enum CodingKeys: String, CodingKey {
        case transferFrom = "TransferFrom"
        case transferTo = "TransferTo"
        case points = "Points"
        case transactiondt = "Transactiondt"
        case transtype = "Transtype"
        case documentName = "DocumentName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        transferFrom = try values.decodeIfPresent(String.self, forKey: .transferFrom)
        transferTo = try values.decodeIfPresent(String.self, forKey: .transferTo)
        transactiondt = try values.decodeIfPresent(String.self, forKey: .transactiondt)
        transtype = try values.decodeIfPresent(String.self, forKey: .transtype)
        documentName = try values.decodeIfPresent(String.self, forKey: .documentName)
    }
}
