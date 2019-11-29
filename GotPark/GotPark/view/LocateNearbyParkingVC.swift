//
//  LocateNearbyParkingVC.swift
//  GotPark
//
//  Created by Richard Perocho on 2019-11-23.
//  Copyright © 2019 Connor Clarkson. All rights reserved.
//

import UIKit
import MapKit

class LocateNearbyParkingVC: UIViewController {
    
    var locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 3000
    @IBOutlet var parkingMap: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        parkingMap.mapType = MKMapType.satellite
        parkingMap.isZoomEnabled = true
        parkingMap.isScrollEnabled = true
        parkingMap.isUserInteractionEnabled = true
        
        //set location manager properties
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        //start getting location updates
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
        }

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
