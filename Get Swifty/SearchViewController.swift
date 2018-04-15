//
//  SearchViewController.swift
//  Get Swifty
//
//  Created by Yousef At-tamimi on 4/6/18.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var searchQuery: UITextField!
    let locationManager = CLLocationManager()
    var longitude : Double = 0.0
    var latitude : Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
     
        performSegue(withIdentifier: "toPosts", sender: self)
        savecoordinates()
    }
    
    func savecoordinates(){
        
        let defaults = UserDefaults.standard
        defaults.set(latitude, forKey: "latitude")
        defaults.set(longitude, forKey: "longitude")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            longitude = location.coordinate.longitude
            latitude = location.coordinate.latitude
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let posts = segue.destination as? PostViewController {
            
            posts.latitude = latitude
            posts.longitude = longitude
            posts.query = searchQuery.text!
        }
    }

}
