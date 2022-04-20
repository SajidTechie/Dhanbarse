//
//  ActiveScheme.swift
//  Dhanbarse
//
//  Created by Goldmedal on 10/16/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation
struct ActiveSchemeElement: Codable {
    let result: Bool?
    let message, servertime: String?
    let data: [ActiveSchemeData]
}

struct ActiveSchemeData: Codable {
    let activeschemedata: [ActiveSchemeObject]
    let ismore: Bool?
}

struct ActiveSchemeObject: Codable {
    let schemeType, schemeName, fromDate, toDate, imgurl: String?
    let link: String?
}
