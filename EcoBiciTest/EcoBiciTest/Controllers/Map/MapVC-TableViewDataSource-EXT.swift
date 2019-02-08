//
//  MapVC-TableViewDataSource-EXT.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/7/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import UIKit

extension MapVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBikes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblBikes.dequeueReusableCell(withIdentifier: "bikesCell", for: indexPath) as! BikeViewCell
        cell.lblNameStation.text    =  "Estación: \(arrBikes[indexPath.row].name)"
        cell.lblAddress.text        =  "Dirección: \(arrBikes[indexPath.row].address) "
        cell.lblAvailability.text   =  "Disponibles: \(arrBikes[indexPath.row].availability)"
        cell.ivMarker.image         =  UIImage(named: arrBikes[indexPath.row].img)
        cell.lblDistance.text       =  "\(arrBikes[indexPath.row].distance) km"
        return cell
    }
}
