//
//  ViewController.swift
//  Where am I?
//
//  Created by Yuen Hsi Chang on 7/21/15.
//  Copyright (c) 2015 yg. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation:CLLocation = locations[0] as! CLLocation
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        self.longtitudeLabel.text = "\(userLocation.coordinate.longitude)"
        self.altitudeLabel.text = "\(userLocation.altitude)"
        self.courseLabel.text = "\(userLocation.course)"
        self.speedLabel.text = "\(userLocation.speed)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                println(error)
            }
            else {
                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark) {
                    var subThoroughfare:String = ""
                    var subLocality:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        subThoroughfare = p.subThoroughfare
                    }
                    
                    if (p.subLocality != nil) {
                        subLocality = p.subLocality + ", "
                    }
                    
                    self.addressLabel.text = "\(subThoroughfare) \(p.thoroughfare) \n\(subLocality)\(p.subAdministrativeArea) \(p.postalCode) \n\(p.country)"
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

