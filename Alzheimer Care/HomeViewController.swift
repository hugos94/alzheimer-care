//
//  HomeViewController.swift
//  Alzheimer Care
//
//  Created by Hugo Santos Piauilino Neto on 05/05/17.
//  Copyright © 2017 Hugo Santos Piauilino. All rights reserved.
//  "B9407F30-F5F8-466E-AFF9-25556B57FE6D"
//  maior = 50668 menor= 34186
//

import UIKit
import CoreLocation
import UserNotifications

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Properties
    
    var auxLonge = 0
    var auxUnknow = 0
    var jaLigou = true
    var jaNotificou = true
    
    var locationManager: CLLocationManager!
    
    let context = DataManager.context
    
    @IBOutlet weak var initialInformationTextView: UITextView!
    
    // MARK: - Actions
    
    @IBAction func makeEmergencyCall() {
        
        let phoneNumber = UserDefaults.standard.string(forKey: "USER_NUMBER")
        
        print("Ligando para \(phoneNumber!)!")
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber!)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    // MARK: - System Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let objIdURL = UserDefaults.standard.url(forKey: "ACTIVE_USER_URL"), let psc = context.persistentStoreCoordinator,
            let objId = psc.managedObjectID(forURIRepresentation: objIdURL), let user = context.object(with: objId) as? User {
            initialInformationTextView.text = "Olá, \(user.name)!"
        } else {
            NSLog("No active user saved -> entering register view")
            performSegue(withIdentifier: "registerSegue", sender: self)
        }
    }
    
    // MARK: - iBeacons Functions
    
    func notificaLonge(){
        
        let alert = UIAlertController(title: "Atenção!", message: "Você está saindo muito longe de sua casa!", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
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
                if self.auxUnknow < 10{
                    self.view.backgroundColor = UIColor.gray
                    print("distance Unknown | aux = \(self.auxUnknow)")
                    self.auxUnknow += 1
                    // self.auxLonge = 0
                }else {
                    if self.jaLigou {
                        self.auxUnknow = 0
                        self.makeEmergencyCall()
                        self.jaLigou = false
                    }
                }
                
            case .far:
                
                self.view.backgroundColor = UIColor.blue
                
                if self.auxLonge < 10{
                    self.auxLonge += 1
                    self.auxUnknow = 0
                    self.jaLigou = true
                    print("Distância longe | aux = \(self.auxLonge)")
                    
                }else {
                    if self.jaNotificou{
                        self.auxLonge = 0
                        self.notificaLonge()
                        self.jaNotificou = false
                    }
                }
                
            case .near:
                self.auxUnknow = 0
                self.auxLonge = 0
                self.jaNotificou = true
                self.jaLigou = true
                self.view.backgroundColor = UIColor.orange
                print("Distância Perto")
                
            case .immediate:
                self.auxUnknow = 0
                self.auxLonge = 0
                self.jaNotificou = true
                self.jaLigou = true
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
            
        }else {
            updateDistance(distance: .unknown)
            print("found only one beacon")
        }
    }
    
    // MARK: - Notification Functions
    
    // 2: Solicitar autorização para enviar notificações
    func registerForNotifications() {
        // Defina o tipo de notificações que você quer permitir
        let notificationTypes: UNAuthorizationOptions = [.sound, .alert, .badge]
        
        // Utilizamos o notification center para solicitar autorização
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Solicitamos autorização
        notificationCenter.requestAuthorization(options: notificationTypes) {
            (granted, error) in
            if granted {
                print("Autorização concedida :D")
            } else {
                print("Autorização negada :(")
            }
        }
    }
    
    
}
