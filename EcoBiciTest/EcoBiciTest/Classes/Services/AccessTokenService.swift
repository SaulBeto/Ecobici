//
//  AccessTokenService.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import Foundation

class AccessTokenService {

    func getResponse(url: URL, completion: @escaping(token) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let error = responseError {
                print(error)
            } else if let jsonData = responseData {
                do{
                    let responseObj = try JSONDecoder().decode(token.self, from: jsonData)
                    completion(responseObj)
                }catch let e{
                    print(e)
                }
            }
        }
        task.resume()
    }
}

