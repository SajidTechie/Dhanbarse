//
//  dealerTransferRevokeData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/19/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct DealerTransferRevokeData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[DealerTransferRevokeObj]?
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
        data = try values.decodeIfPresent([DealerTransferRevokeObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}


struct DealerTransferRevokeObj: Codable {
   let points : Int?
    let retailerName : String?
    let dealerName : String?
    let transdate : String?

    enum CodingKeys: String, CodingKey {

        case points = "Points"
        case retailerName = "RetailerName"
        case dealerName = "DealerName"
        case transdate = "Transdate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        retailerName = try values.decodeIfPresent(String.self, forKey: .retailerName)
        dealerName = try values.decodeIfPresent(String.self, forKey: .dealerName)
        transdate = try values.decodeIfPresent(String.self, forKey: .transdate)
    }
}
