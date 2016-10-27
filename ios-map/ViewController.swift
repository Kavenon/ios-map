//
//  ViewController.swift
//  ios-map
//
//  Created by Użytkownik Gość on 27.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var locationManager : CLLocationManager!;
    
    @IBAction func startButtonAction(sender: AnyObject) {
        stopButton.enabled = true;
        startButton.enabled = false;
        locationManager.startUpdatingLocation();
        mapView.showsUserLocation = true;
    }
    
    @IBAction func stopButtonAction(sender: AnyObject) {
        stopButton.enabled = false;
        startButton.enabled = true;
        locationManager.stopUpdatingLocation();
        mapView.showsUserLocation = false;
        
    }
    
    @IBAction func clearButtonAction(sender: AnyObject) {
        mapView.removeAnnotations(mapView.annotations);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopButton.enabled = false;
        
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        let lastLocation = locations.last?.coordinate
            
        let marker = MKPointAnnotation()
            marker.coordinate = lastLocation!
            mapView.addAnnotation(marker)
            
            var delta = 0.0
            
            if let speed = locations.last?.speed where speed > 0 {
                delta = (locations.last?.speed)! / 5000
            }
            
            let locationArea = MKCoordinateRegion(center: lastLocation!, span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
            mapView.setRegion(locationArea, animated: true)
            
    }


}

