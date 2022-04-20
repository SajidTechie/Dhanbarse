//
//  UpdateData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 12/2/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation

// MARK: - UpdateData
struct PersonalAddressUpdate: Codable {
      let version: String?
      let statusCode: Int?
      let statusCodeMessage, timestamp: String?
      let size: Int?
      let data:[PersonalAddressObj]?
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
          data = try values.decodeIfPresent([PersonalAddressObj].self, forKey: .data)
          errors = try values.decodeIfPresent([ErrorData].self, forKey: .errors)
      }
}

struct PersonalAddressObj: Codable {
          let slno : Int?
          let userCategoryId : Int?
          let userName : String?
          let userSurname : String?
          let mobileNo : String?
          let profileImgType : String?
          let profileImgLink : String?
          let secContactNo : String?
          let sex : String?
          let email : String?
          let secEmail : String?
          let refCode : String?
          let dateOfBirth : String?
          let updateStatus : Int?

          enum CodingKeys: String, CodingKey {
              case slno = "slno"
              case userCategoryId = "UserCategoryId"
              case userName = "UserName"
              case userSurname = "UserSurname"
              case mobileNo = "MobileNo"
              case profileImgType = "ProfileImgType"
              case profileImgLink = "ProfileImgLink"
              case secContactNo = "SecContactNo"
              case sex = "Sex"
              case email = "Email"
              case secEmail = "SecEmail"
              case refCode = "RefCode"
              case dateOfBirth = "DateOfBirth"
              case updateStatus = "UpdateStatus"
          }

          init(from decoder: Decoder) throws {
              let values = try decoder.container(keyedBy: CodingKeys.self)
              slno = try values.decodeIfPresent(Int.self, forKey: .slno)
              userCategoryId = try values.decodeIfPresent(Int.self, forKey: .userCategoryId)
              userName = try values.decodeIfPresent(String.self, forKey: .userName)
              userSurname = try values.decodeIfPresent(String.self, forKey: .userSurname)
              mobileNo = try values.decodeIfPresent(String.self, forKey: .mobileNo)
              profileImgType = try values.decodeIfPresent(String.self, forKey: .profileImgType)
              profileImgLink = try values.decodeIfPresent(String.self, forKey: .profileImgLink)
              secContactNo = try values.decodeIfPresent(String.self, forKey: .secContactNo)
              sex = try values.decodeIfPresent(String.self, forKey: .sex)
              email = try values.decodeIfPresent(String.self, forKey: .email)
              secEmail = try values.decodeIfPresent(String.self, forKey: .secEmail)
              refCode = try values.decodeIfPresent(String.self, forKey: .refCode)
              dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
              updateStatus = try values.decodeIfPresent(Int.self, forKey: .updateStatus)
          }

      }
