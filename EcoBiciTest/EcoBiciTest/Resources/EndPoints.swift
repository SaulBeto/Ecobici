//
//  EndPoints.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import Foundation

struct Endpoints {
    static let stations          = "https://pubsbapi.smartbike.com/api/v1/stations.json"
    static let stationsStatus    = "https://pubsbapi.smartbike.com/api/v1/stations/status.json"
    static let access_token      = "https://pubsbapi.smartbike.com/oauth/v2/token?client_id=\(EcobiciConstants.CLIENT_ID)&client_secret=\(EcobiciConstants.CLIENT_SECRET)&grant_type=client_credentials"
}
