//
//  GetProfileData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/2/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation

// MARK: - GetProfile
struct GetProfileElement: Codable {
    let version: String?
    let statusCode: Int?
    let statusCodeMessage, timestamp: String?
    let size: Int?
    let errors: [ErrorData]?
    let data: [ProfileObj]?
    
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
           data = try values.decodeIfPresent([ProfileObj].self, forKey: .data)
           errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
       }
}


// MARK: - Datum
struct ProfileObj: Codable {
       let slNo : Int?
            let categorynm : String?
            let userName : String?
            let userSurname : String?
            let mobileNo : String?
            let dateOfBirth : String?
            let sex : String?
            let refCode : String?
            let email : String?
            let approvalStatus : String?
            let updateStatus : Int?
            let shopName : String?
            let shopEstCerti : String?
            let shopPhoto : String?
            let gSTNO : String?
            let gstscan : String?
            let profilephoto : String?
            let addresses : [Addresses]?
            let kyc : [Kyc]?

            enum CodingKeys: String, CodingKey {

                case slNo = "SlNo"
                case categorynm = "Categorynm"
                case userName = "UserName"
                case userSurname = "UserSurname"
                case mobileNo = "MobileNo"
                case dateOfBirth = "DateOfBirth"
                case sex = "Sex"
                case refCode = "RefCode"
                case email = "Email"
                case approvalStatus = "ApprovalStatus"
                case updateStatus = "UpdateStatus"
                case shopName = "ShopName"
                case shopEstCerti = "ShopEstCerti"
                case shopPhoto = "ShopPhoto"
                case gSTNO = "GSTNO"
                case gstscan = "Gstscan"
                case profilephoto = "Profilephoto"
                case addresses = "Addresses"
                case kyc = "Kyc"
            }

            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
                categorynm = try values.decodeIfPresent(String.self, forKey: .categorynm)
                userName = try values.decodeIfPresent(String.self, forKey: .userName)
                userSurname = try values.decodeIfPresent(String.self, forKey: .userSurname)
                mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
                dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
                sex = try values.decodeIfPresent(String.self, forKey: .sex)
                refCode = try values.decodeIfPresent(String.self, forKey: .refCode)
                email = try values.decodeIfPresent(String.self, forKey: .email)
                approvalStatus = try values.decodeIfPresent(String.self, forKey: .approvalStatus)
                updateStatus = try values.decodeIfPresent(Int.self, forKey: .updateStatus)
                shopName = try values.decodeIfPresent(String.self, forKey: .shopName)
                shopEstCerti = try values.decodeIfPresent(String.self, forKey: .shopEstCerti)
                shopPhoto = try values.decodeIfPresent(String.self, forKey: .shopPhoto)
                gSTNO = try values.decodeIfPresent(String.self, forKey: .gSTNO)
                gstscan = try values.decodeIfPresent(String.self, forKey: .gstscan)
                profilephoto = try values.decodeIfPresent(String.self, forKey: .profilephoto)
                addresses = try values.decodeIfPresent([Addresses].self, forKey: .addresses)
                kyc = try values.decodeIfPresent([Kyc].self, forKey: .kyc)
            }

        }

struct Kyc : Codable {
    let kycType : Int?
    let docNo : String?
    let docImage1 : String?
    let docImage2 : String?

    enum CodingKeys: String, CodingKey {

        case kycType = "KycType"
        case docNo = "DocNo"
        case docImage1 = "DocImage1"
        case docImage2 = "DocImage2"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kycType = try values.decodeIfPresent(Int.self, forKey: .kycType)
        docNo = try values.decodeIfPresent(String.self, forKey: .docNo)
        docImage1 = try values.decodeIfPresent(String.self, forKey: .docImage1)
        docImage2 = try values.decodeIfPresent(String.self, forKey: .docImage2)
    }
}

struct Addresses : Codable {
        let type : Int?
        let address1 : String?
        let address2 : String?
        let stateId : Int?
        let districtId : Int?
        let state : String?
        let district : String?
        let city : String?
        let pinCode : String?

        enum CodingKeys: String, CodingKey {

            case type = "Type"
            case address1 = "Address1"
            case address2 = "Address2"
            case stateId = "StateId"
            case districtId = "DistrictId"
            case state = "State"
            case district = "District"
            case city = "City"
            case pinCode = "PinCode"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            type = try values.decodeIfPresent(Int.self, forKey: .type)
            address1 = try values.decodeIfPresent(String.self, forKey: .address1)
            address2 = try values.decodeIfPresent(String.self, forKey: .address2)
            stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
            districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
            state = try values.decodeIfPresent(String.self, forKey: .state)
            district = try values.decodeIfPresent(String.self, forKey: .district)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            pinCode = try values.decodeIfPresent(String.self, forKey: .pinCode)
        }
}

