//
//  StationsService.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import Foundation

class StationService {
    
    func getResponse(url: URL, completion: @escaping([station]) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "access_token")!)"]
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                print("Error")
                print(error)
            } else if let jsonData = responseData {
                
                print(jsonData)
                do{
                    
                   
                    let responseObj = try JSONDecoder().decode(item.self, from: jsonData)
                     //print(responseObj)
                    completion(responseObj.stations)
                    
                }catch let e{
                    print(e)
                }
            }
        }
        task.resume()
    }
}
