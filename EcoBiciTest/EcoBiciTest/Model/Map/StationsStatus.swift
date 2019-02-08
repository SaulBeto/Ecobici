//
//  StationsStatus.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import Foundation

struct status: Decodable {
    let stationsStatus: [stationStatus]
}

struct stationStatus: Decodable {
    let id: Int
    let availability: availability
}

struct availability: Decodable {
    let bikes: Int
}
