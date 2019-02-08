//
//  StationsStatusService.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/6/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import Foundation

class StationStatusService {

    func getResponse(url: URL, completion: @escaping([stationStatus]) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "access_token")!)"]
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                print(error)
            } else if let jsonData = responseData {

                do{
                    let responseObj = try JSONDecoder().decode(status.self, from: jsonData)
                    //print(responseObj)
                    completion(responseObj.stationsStatus)
                    
                }catch let e{
                    print(e)
                }
            }
        }
        task.resume()
    }

}
