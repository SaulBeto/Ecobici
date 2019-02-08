//
//  MapVC-GMSMapDelegate-EXT.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import GoogleMaps

extension MapVC: GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        var originX: CGFloat = 0
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let ivBike = UIImageView(frame: CGRect.init(x: 5,
                                                    y: 5,
                                                    width: 40,
                                                    height: 40))
        ivBike.image = UIImage(named: "bike")
        ivBike.contentMode = .scaleAspectFill
        view.addSubview(ivBike)
        
        originX = ivBike.frame.origin.x + ivBike.frame.width + 5

        let lblAvailability = UILabel(frame: CGRect.init(x: originX,
                                                         y: 5,
                                                         width: 40,
                                                         height: 40))
        lblAvailability.text = "\(arrBikes[indexBike].availability)"
        lblAvailability.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.addSubview(lblAvailability)
        
        originX = lblAvailability.frame.origin.x + lblAvailability.frame.height + 20

        let lblDistance = UILabel(frame: CGRect.init(x: originX,
                                                     y: 5,
                                                     width: 50,
                                                     height: 40))
        lblDistance.text = "\(arrBikes[indexBike].distance) km"
        lblDistance.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        view.addSubview(lblDistance)
        
        let lblName = UILabel(frame: CGRect.init(x: ivBike.frame.origin.x,
                                                     y: ivBike.frame.origin.y + ivBike.frame.height + 5,
                                                     width: view.frame.width - 10,
                                                     height: 15))
        lblName.text = "\(arrBikes[indexBike].name)"
        lblName.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.addSubview(lblName)

        return view
    }
}
