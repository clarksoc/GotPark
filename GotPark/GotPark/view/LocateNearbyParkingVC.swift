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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
        }

    }
    
   @IBAction func doNearbySearchClick(){
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "parking"
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        request.region = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        let search = MKLocalSearch(request: request)
        
        search.start(completionHandler: {(response, error) in
            
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            for item in response.mapItems {
                self.addPinToMapView(title: item.name, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
            
            //zoom out the map
            var region: MKCoordinateRegion = self.parkingMap.region
            var span: MKCoordinateSpan = self.parkingMap.region.span
            span.latitudeDelta *= 4
            span.longitudeDelta *= 4
            region.span = span
            self.parkingMap.setRegion(region, animated: true)
        })
        
    }
    

}

extension LocateNearbyParkingVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.last != nil {
            print("location:: \(locations)")
        }
        
        print("Updating location")
        
        let center = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        print("Center: \(center)")
        
        let region = MKCoordinateRegion(center: center,latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.parkingMap.setRegion(region, animated: true)
        
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = center
        myAnnotation.title = "You are here"
        parkingMap.addAnnotation(myAnnotation)
        
    }
    
    func addPinToMapView(title: String?, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        if let title = title {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let myAnnotation = MKPointAnnotation()
            
            myAnnotation.coordinate = location
            myAnnotation.title = title
            
            self.parkingMap.addAnnotation(myAnnotation)
        }
    }

}

