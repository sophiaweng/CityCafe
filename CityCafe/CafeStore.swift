//
//  CafeStore.swift
//  CityCafe
//
//  Created by 翁淑惠 on 2020/12/15.
//

import Foundation

struct CafeStore: Codable {
    var name: String
    var city: String
    var tasty: Double?
    var url: String?
    var address: String?
    var latitude: String?
    var longitude: String?
    var open_time: String?
}

enum city: String {
    case taipei
    case hsinchu
    case kaohsiung
}
