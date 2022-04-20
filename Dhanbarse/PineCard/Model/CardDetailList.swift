//
//  CardDetailList.swift
//  Dhanbarse
//
//  Created by Goldmedal on 10/12/21.
//  Copyright © 2021 Goldmedal. All rights reserved.
//

import Foundation
struct CardDetailListData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[CardDetailListMain]?
    let errors: [ErrorCardDetailList]?
    
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
        data = try values.decodeIfPresent([CardDetailListMain].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorCardDetailList].self, forKey: .errors)
    }
}


struct CardDetailListMain: Codable {
    let CardID: Int
    let CardRequestID: Int
    let CardRequestNo: String
    let RequestUserID: Int
    let CardHolderFirstName: String
    let CardHolderLastName: String
    let CardHolderMobileNumber: String
    let CardHolderPANNo: String
    let CardHolderEmail: String
    let ContactPersonName: String
    let ContactPersonContactNo: String
    let AddressLine1: String
    let AddressLine2: String
    let Locality: String
    let Pincode: String
    let City: String
    let StateName: String
    let DistrictName: String
    let IsReIssue: String
    let CardStatus: String
    let RequestDate: String
    let ReIssueReason: String
    let Remark: String
    
    private enum CodingKeys: String, CodingKey {
        case CardID = "CardID"
        case CardRequestID = "CardRequestID"
        case CardRequestNo = "CardRequestNo"
        case RequestUserID = "RequestUserID"
        case CardHolderFirstName = "CardHolderFirstName"
        case CardHolderLastName = "CardHolderLastName"
        case CardHolderMobileNumber = "CardHolderMobileNumber"
        case CardHolderPANNo = "CardHolderPANNo"
        case CardHolderEmail = "CardHolderEmail"
        case ContactPersonName = "ContactPersonName"
        case ContactPersonContactNo = "ContactPersonContactNo"
        case AddressLine1 = "AddressLine1"
        case AddressLine2 = "AddressLine2"
        case Locality = "Locality"
        case Pincode = "Pincode"
        case City = "City"
        case StateName = "StateName"
        case DistrictName = "DistrictName"
        case IsReIssue = "IsReIssue"
        case CardStatus = "CardStatus"
        case RequestDate = "RequestDate"
        case ReIssueReason = "ReIssueReason"
        case Remark = "Remark"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        CardID = try values.decode(Int.self, forKey: .CardID)
        CardRequestID = try values.decode(Int.self, forKey: .CardRequestID)
        CardRequestNo = try values.decode(String.self, forKey: .CardRequestNo)
        RequestUserID = try values.decode(Int.self, forKey: .RequestUserID)
        CardHolderFirstName = try values.decode(String.self, forKey: .CardHolderFirstName)
        CardHolderLastName = try values.decode(String.self, forKey: .CardHolderLastName)
        CardHolderMobileNumber = try values.decode(String.self, forKey: .CardHolderMobileNumber)
        CardHolderPANNo = try values.decode(String.self, forKey: .CardHolderPANNo)
        CardHolderEmail = try values.decode(String.self, forKey: .CardHolderEmail)
        ContactPersonName = try values.decode(String.self, forKey: .ContactPersonName)
        ContactPersonContactNo = try values.decode(String.self, forKey: .ContactPersonContactNo)
        AddressLine1 = try values.decode(String.self, forKey: .AddressLine1)
        AddressLine2 = try values.decode(String.self, forKey: .AddressLine2)
        Locality = try values.decode(String.self, forKey: .Locality)
        Pincode = try values.decode(String.self, forKey: .Pincode)
        City = try values.decode(String.self, forKey: .City)
        StateName = try values.decode(String.self, forKey: .StateName)
        DistrictName = try values.decode(String.self, forKey: .DistrictName)
        IsReIssue = try values.decode(String.self, forKey: .IsReIssue)
        CardStatus = try values.decode(String.self, forKey: .CardStatus)
        RequestDate = try values.decode(String.self, forKey: .RequestDate)
        ReIssueReason = try values.decode(String.self, forKey: .ReIssueReason)
        Remark = try values.decode(String.self, forKey: .Remark)
    }
}

struct ErrorCardDetailList : Codable {
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
