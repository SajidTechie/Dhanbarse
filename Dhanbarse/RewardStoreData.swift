//
//  RewardStoreData.swift
//  Dhanbarse
//
//  Created by Goldmedal on 11/6/19.
//  Copyright © 2019 Goldmedal. All rights reserved.
//

import Foundation

struct RewardStoreElement: Codable {
    let result: Bool?
    let message, servertime: String?
    let data: [RewardStoreData]
}

struct RewardStoreData: Codable {
    let divisionid: Int?
    let catid: Int?
    let catnm, catimage,divisionnm: String?
}
