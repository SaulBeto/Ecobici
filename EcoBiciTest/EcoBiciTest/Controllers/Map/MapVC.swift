//
//  MapVC.swift
//  EcoBiciTest
//
//  Created by Saul Alberto Cortez Garcia on 2/5/19.
//  Copyright © 2019 SaulCortez. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {
    
    //MARK: - Variables
    var locationManager = CLLocationManager()
    var latitude : Double = 0
    var longitude : Double = 0
    var arrBikes = [Bike]()
    var indexBike: Int!
    
    //MARK: - IBOutlets
    var mapView: GMSMapView!
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tblBikes: UITableView!
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Estaciones cercanas"
        
        drawUI()
        setUpTableView()
        activityIndicator.startAnimating()
        setUpPermissions()
        
    }
    
    //MARK: - Functions
    
    
    /**
     * Description: This method draw an activity indicator
     * Parameters: any
     */
    func drawUI(){
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                  y: 0,
                                                                  width: 100,
                                                                  height: 100))
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = CGPoint(x: view.frame.width / 2,
                                           y: view.frame.height / 2)
        view.addSubview(activityIndicator)
    }
    
    /**
     * Description: This method sets delegate and datasource of tableview
     * Parameters: any
     */
    func setUpTableView(){
        tblBikes.delegate = self
        tblBikes.dataSource = self
    }
    
    
    /**
     * Description: This method asks to user permissions to have location access
     * Parameters: any
     */
    func setUpPermissions(){
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            callServices()
        }else{
            fatalError("Not permission to location access")
        }
    }
    
    
    /**
     * Description: This method draws map and subviews in principal view
     * Parameters: any
     */
    func setUpMap(){
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0,
                                                   y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: UIScreen.main.bounds.height),
                                 camera: camera)
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        mapView.isHidden = true
        view.addSubview(mapView)
        
        let btnBack = UIButton(frame: CGRect(x: 20, y: mapView.bounds.height * 0.10, width: 50 , height: 50))
        
        btnBack.backgroundColor = UIColor.white
        btnBack.setImage(UIImage(named: "left-arrow"), for: .normal)
        btnBack.layer.cornerRadius = btnBack.frame.height/2
        btnBack.layer.shadowColor = UIColor.gray.cgColor
        btnBack.layer.shadowOpacity = 1
        btnBack.layer.shadowOffset = CGSize.zero
        btnBack.layer.shadowRadius = 5
        btnBack.addTarget(self, action: #selector(actBackToTable), for: .touchUpInside)
        mapView.addSubview(btnBack)
    }
    
    
    /**
     * Description: This method calls web services to consume. The services call are: stations, stations status and access tooken
     * Parameters: any
     */
    func callServices(){
        
        let accessToken = AccessTokenService()
        let urlAccessToken = URL(string: Endpoints.access_token)
        accessToken.getResponse(url: urlAccessToken!) { (response) in
            
            UserDefaults.standard.set("\(response.access_token)", forKey: "access_token")
            
            let stationsService = StationService()
            let url = URL(string: Endpoints.stations)
            stationsService.getResponse(url: url!) { (responseBikes) in

                let stationsStatus = StationStatusService()
                let url = URL(string: Endpoints.stationsStatus)
                stationsStatus.getResponse(url: url!, completion: { (responseBikesStatus) in

                   self.arrBikes = self.getFirstTwentyFiveBikesFromMe(responseBikes, responseBikesStatus)
                    
                    DispatchQueue.main.async {
                        self.setUpMap()
                        self.activityIndicator.stopAnimating()
                        self.tblBikes.reloadData()
                    }
                })
 
            }
        }
    }
    
    /**
     * Description: This method get the first tewnty five stations nearly to user and return a new array of Bike information.
     * Parameters: bikesStations: To manage the 25 stations and set it in new array, bikeStatus: To manage the 25 stations and set it in new array
     */
    func getFirstTwentyFiveBikesFromMe(_ bikesStations: [station],_ bikesStatus: [stationStatus]) -> [Bike]{
        
        var bikes = Bike()
        var arrBikes = [Bike]()
        var arrBikesTemp = [Bike]()
        
        for item in bikesStations{
            for ava in bikesStatus{
                
                if item.id == ava.id{
                    
                    let coordinate₀ = CLLocation(latitude: self.latitude, longitude: self.longitude)
                    let coordinate₁ = CLLocation(latitude: item.location.lat, longitude: item.location.lon)
                    let distanceInMeters = coordinate₀.distance(from: coordinate₁)
                    let distanceInKM = Double(String(format: "%.1f", (distanceInMeters * 0.001)))

                    bikes.address       = item.address
                    bikes.id            = item.id
                    bikes.name          = item.name
                    bikes.latitude      = item.location.lat
                    bikes.longitude     = item.location.lon
                    bikes.distance      = distanceInKM!
                    bikes.availability  = ava.availability.bikes

                    bikes.img = bikes.availability == 0 ? "none" : ( bikes.availability > 0 && bikes.availability <= 10 ? "warning" : "available")
                    
                    arrBikesTemp.append(bikes)
                }
            }
        }
        
        let newArrSorted = arrBikesTemp.sorted{ (bike, bike2) -> Bool in
            return bike.distance < bike2.distance
        }
        
        for first25Bikes in 0..<25{
            arrBikes.append(newArrSorted[first25Bikes])
        }
        return arrBikes
    }
    
    /**
     * Description: This method has a delay an animate google maps transitions
     * Parameters: seconds: to delay time
     */
    func delay(seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }
    
    //MARK: - IBActions
    
    @objc func actBackToTable(){
        mapView.clear()
        tblBikes.isHidden = false
        mapView.isHidden = true
        navigationController?.navigationBar.isHidden = false
    }
}



