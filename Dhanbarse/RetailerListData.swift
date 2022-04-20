//
//  RetailerListData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 3/19/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct RetailerListData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[RetailerListMain]?
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
        data = try values.decodeIfPresent([RetailerListMain].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
    }
}

struct RetailerListMain : Codable {
    let retailersList : [RetailerListObj]?
    let ismore : Bool?

    enum CodingKeys: String, CodingKey {

        case retailersList = "RetailersList"
        case ismore = "ismore"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retailersList = try values.decodeIfPresent([RetailerListObj].self, forKey: .retailersList)
        ismore = try values.decodeIfPresent(Bool.self, forKey: .ismore)
    }

}



struct RetailerListObj: Codable {
    let slNo : Int?
    let name : String?
    let shopName : String?
    let mobileNo : String?
    let revocablePoints : Double?
    
    enum CodingKeys: String, CodingKey {
        case slNo = "slno"
        case name = "Name"
        case shopName = "ShopName"
        case mobileNo = "MobileNo"
        case revocablePoints = "RevocablePoints"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        shopName = try values.decodeIfPresent(String.self, forKey: .shopName)
        mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
        revocablePoints = try values.decodeIfPresent(Double.self, forKey: .revocablePoints)
    }
}


