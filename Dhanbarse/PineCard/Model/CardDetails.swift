//
//  CardDetails.swift
//  Dhanbarse
//
//  Created by Goldmedal on 10/12/21.
//  Copyright © 2021 Goldmedal. All rights reserved.
//

import Foundation
struct CardDetailsData: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let data:[CardDetailsMain]?
    let errors: [ErrorCardDetails]?
    
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
        data = try values.decodeIfPresent([CardDetailsMain].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorCardDetails].self, forKey: .errors)
    }
}


struct CardDetailsMain: Codable {
    
    let CardID: Int
    let CardLink: String
    let CardName: String
    let BlockedOn: String
    let TerminatedOn: String
    let LastCreditedOn: String
    let ActivatedOn: String
    let IssuedOn: String
    let ExpiryDate: String
    let MaskedCardNumber: String
    let CardStatus: String
    let KycStatus: String
    let LoadAmount: Int
    let RedeemedAmount: Int
    let Balance: Int
    let BlockedAmount: Int
    let MonthlyCreditAmount: Int
    let CustomerName: String
    let Reason: String

    private enum CodingKeys: String, CodingKey {
        case CardID = "CardID"
        case CardLink = "CardLink"
        case CardName = "CardName"
        case BlockedOn = "BlockedOn"
        case TerminatedOn = "TerminatedOn"
        case LastCreditedOn = "LastCreditedOn"
        case ActivatedOn = "ActivatedOn"
        case IssuedOn = "IssuedOn"
        case ExpiryDate = "ExpiryDate"
        case MaskedCardNumber = "MaskedCardNumber"
        case CardStatus = "CardStatus"
        case KycStatus = "KycStatus"
        case LoadAmount = "LoadAmount"
        case RedeemedAmount = "RedeemedAmount"
        case Balance = "Balance"
        case BlockedAmount = "BlockedAmount"
        case MonthlyCreditAmount = "MonthlyCreditAmount"
        case CustomerName = "CustomerName"
        case Reason = "Reason"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        CardID = try values.decode(Int.self, forKey: .CardID)
        CardLink = try values.decode(String.self, forKey: .CardLink)
        CardName = try values.decode(String.self, forKey: .CardName)
        BlockedOn = try values.decode(String.self, forKey: .BlockedOn)
        TerminatedOn = try values.decode(String.self, forKey: .TerminatedOn)
        LastCreditedOn = try values.decode(String.self, forKey: .LastCreditedOn)
        ActivatedOn = try values.decode(String.self, forKey: .ActivatedOn)
        IssuedOn = try values.decode(String.self, forKey: .IssuedOn)
        ExpiryDate = try values.decode(String.self, forKey: .ExpiryDate)
        MaskedCardNumber = try values.decode(String.self, forKey: .MaskedCardNumber)
        CardStatus = try values.decode(String.self, forKey: .CardStatus)
        KycStatus = try values.decode(String.self, forKey: .KycStatus)
        LoadAmount = try values.decode(Int.self, forKey: .LoadAmount)
        RedeemedAmount = try values.decode(Int.self, forKey: .RedeemedAmount)
        Balance = try values.decode(Int.self, forKey: .Balance)
        BlockedAmount = try values.decode(Int.self, forKey: .BlockedAmount)
        MonthlyCreditAmount = try values.decode(Int.self, forKey: .MonthlyCreditAmount)
        CustomerName = try values.decode(String.self, forKey: .CustomerName)
        Reason = try values.decode(String.self, forKey: .Reason)
    }

}

struct ErrorCardDetails : Codable {
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

