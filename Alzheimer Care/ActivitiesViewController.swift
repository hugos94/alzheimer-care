//
//  ActivitiesViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 07/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//

import UIKit
import CoreLocation

class ActivitiesViewController: UIViewController,CLLocationManagerDelegate{
    
    //"B9407F30-F5F8-466E-AFF9-25556B57FE6D"
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedAlways{
            print("status authorized")
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                print("is monitoring")
                if CLLocationManager.isRangingAvailable() {
                    print("scanning")
                    startScanning()
                    
                }
            }
        }
    }
    
    func startScanning() {
        print("start Scanning")
        
        if let uuid = NSUUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D") {
            let beaconRegion = CLBeaconRegion(proximityUUID: uuid as UUID, identifier: "MyBeacon")
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(in: beaconRegion)
            
            locationManager.startMonitoring(for: beaconRegion)
            locationManager.startRangingBeacons(in: beaconRegion)
        }
        else {
            print("Invalid UUID format")
        }
        
    }
    
    
    
    func updateDistance(distance: CLProximity){
        
        UIView.animate(withDuration: 1) { [unowned self] in
            
            switch distance {
            case .unknown:
                
                self.view.backgroundColor = UIColor.gray
                print("distance Unknown")
            case .far:
                
                self.view.backgroundColor = UIColor.blue
                print("Distância longe")
            case .near:
                
                self.view.backgroundColor = UIColor.orange
                print("Distância Perto")
            case .immediate:
                
                self.view.backgroundColor = UIColor.brown
                print("Distância Imediata")
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.unknown }
        if knownBeacons.count > 0 {
            let beacon = beacons.first! as CLBeacon
            
            updateDistance(distance: beacon.proximity)
            
            print("found more than one beacon | MAJOR =\(beacon.major) && MENOR = \(beacon.minor) \n ---> \(beacon.proximityUUID) \n")
        }
        //else {
        //  updateDistance(distance: .unknown)
        //print("found only one beacon")
        //}
    }
    
}
