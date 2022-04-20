//
//  QrCodeTransferData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/16/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct QrCodeTransferData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[QrCodeTransferObj]?
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
        data = try values.decodeIfPresent([QrCodeTransferObj].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}


struct QrCodeTransferObj: Codable {
   let statusCode : Int?
    let statusMessage : String?
    let statusDescription : String?
    let requestGuid : String?
    let amount : Double?
    let orderId : String?
    let walletTransactionId : String?

    enum CodingKeys: String, CodingKey {

        case statusCode = "StatusCode"
        case statusMessage = "StatusMessage"
        case statusDescription = "StatusDescription"
        case requestGuid = "RequestGuid"
        case amount = "Amount"
        case orderId = "OrderId"
        case walletTransactionId = "WalletTransactionId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMessage = try values.decodeIfPresent(String.self, forKey: .statusMessage)
        statusDescription = try values.decodeIfPresent(String.self, forKey: .statusDescription)
        requestGuid = try values.decodeIfPresent(String.self, forKey: .requestGuid)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        orderId = try values.decodeIfPresent(String.self, forKey: .orderId)
        walletTransactionId = try values.decodeIfPresent(String.self, forKey: .walletTransactionId)
    }
}

