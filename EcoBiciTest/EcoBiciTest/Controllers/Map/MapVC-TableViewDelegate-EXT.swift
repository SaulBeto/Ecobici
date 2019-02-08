//
//  MapVC-TableViewDelegate-EXT.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/7/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import GoogleMaps
import UIKit

extension MapVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        navigationController?.navigationBar.isHidden = true
        indexBike = indexPath.row
        tblBikes.isHidden = true
        mapView.isHidden = false
        
        delay(seconds: 1.0) { () -> () in
            let zoomOut = GMSCameraUpdate.zoom(to: 14)
            self.mapView.animate(with: zoomOut)
            
            self.delay(seconds: 0.5, closure: { () -> () in
                
                let newLocation = CLLocationCoordinate2DMake(self.arrBikes[indexPath.row].latitude,self.arrBikes[indexPath.row].longitude)
                let newLocationCam = GMSCameraUpdate.setTarget(newLocation)
                self.mapView.animate(with: newLocationCam)
                
                self.delay(seconds: 1.0, closure: { () -> () in
                    let zoomIn = GMSCameraUpdate.zoom(to: 16)
                    self.mapView.animate(with: zoomIn)
                    
                })
            })
        }
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: arrBikes[indexPath.row].latitude, longitude: arrBikes[indexPath.row].longitude)
        
        marker.icon = UIImage(named: arrBikes[indexPath.row].img)?.withRenderingMode(.alwaysTemplate)
        marker.map = mapView
        
    }
}
