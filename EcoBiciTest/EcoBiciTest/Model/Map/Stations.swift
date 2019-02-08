//
//  Stations.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import Foundation

struct item: Decodable {
    let stations: [station]
}

struct station: Decodable {
    let id: Int
    let name: String
    let address: String
    let location: location
}

struct location: Decodable {
    let lat: Double
    let lon: Double
}


