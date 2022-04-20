//
//  GetHomePageProductList.swift
//  Dhanbarse
//
//  Created by Goldmedal on 6/28/20.
//  Copyright © 2020 Goldmedal. All rights reserved.
//

import Foundation
struct HomePageProductData: Codable {
    let version : String?
    let statusCode : Int?
    let statusCodeMessage : String?
    let timestamp : String?
    let size : Int?
    let data : [HomePageProductList]?
    let errors : [ErrorDataHomePageProduct]?
    
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
        data = try values.decodeIfPresent([HomePageProductList].self, forKey: .data)
        errors = try values.decodeIfPresent([ErrorDataHomePageProduct].self, forKey: .errors)
    }
    
}


struct HomePageProductList : Codable {
    let slNo : Int?
    let name : String?
    let points : Int?
    let productCategoryId : Int?
    let productCategory : String?
    let productPic : String?
    let totalCount : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case slNo = "SlNo"
        case name = "Name"
        case points = "Points"
        case productCategoryId = "ProductCategoryId"
        case productCategory = "ProductCategory"
        case productPic = "ProductPic"
        case totalCount = "TotalCount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        slNo = try values.decodeIfPresent(Int.self, forKey: .slNo)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        points = try values.decodeIfPresent(Int.self, forKey: .points)
        productCategoryId = try values.decodeIfPresent(Int.self, forKey: .productCategoryId)
        productCategory = try values.decodeIfPresent(String.self, forKey: .productCategory)
        productPic = try values.decodeIfPresent(String.self, forKey: .productPic)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
    }
    
}

struct ErrorDataHomePageProduct : Codable {
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
