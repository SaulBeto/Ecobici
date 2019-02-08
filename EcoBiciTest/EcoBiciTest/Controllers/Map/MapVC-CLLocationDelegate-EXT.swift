//
//  MapVC-CLLocationDelegate.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//
import CoreLocation

extension MapVC: CLLocationManagerDelegate{
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location : CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        latitude = location.latitude
        longitude = location.longitude
        
    }
}
