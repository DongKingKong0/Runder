//
//  ActivityController.swift
//  Runder
//
//  Copyright © 2018 New Image. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ActivityController: UIViewController, CLLocationManagerDelegate {
    
    let activityRecorder = ActivityRecorder()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        activityRecorder.startActivity()
        
        print("start")
        
        startButton.isHidden = true
        pauseButton.isHidden = false
        stopButton.isHidden = false
        
        hideStatLabels()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        activityRecorder.stopActivity()
        
        print("stop")
        
        startButton.isHidden = false
        stopButton.isHidden = true
        pauseButton.isHidden = true
        resumeButton.isHidden = true
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        activityRecorder.pauseActivity()
        
        print("pause")
        
        pauseButton.isHidden = true
        resumeButton.isHidden = false
    }
    
    @IBAction func resumeButtonPressed(_ sender: Any) {
        activityRecorder.resumeActivity()
        
        print("resume")
        
        resumeButton.isHidden = true
        pauseButton.isHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round buttons
        setButtonStyle(button: startButton)
        setButtonStyle(button: stopButton)
        setButtonStyle(button: pauseButton)
        setButtonStyle(button: resumeButton)
        
        stopButton.isHidden = true
        pauseButton.isHidden = true
        resumeButton.isHidden = true
        
        hideStatLabels()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //locationManager.allowsBackgroundLocationUpdates = true
            locationManager.startUpdatingLocation()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        guard let lastLocation = locations.last else { return }
        
        activityRecorder.locationDidChange(lat: locValue.latitude, long: locValue.longitude, alt: lastLocation.altitude)
        
        print("Location updated: lat: \(locValue.latitude) long: \(locValue.longitude) alt: \(lastLocation.altitude)")
    }
    
    
    func setButtonStyle(button: UIButton) {
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
    }
    
    
    func showStatLabels() {
        distanceLabel.isHidden = false
        durationLabel.isHidden = false
        speedLabel.isHidden = false
    }
    
    func hideStatLabels() {
        distanceLabel.isHidden = true
        durationLabel.isHidden = true
        speedLabel.isHidden = true
    }
    
    func showStats() {
        /*distanceLabel.text = "Distance: \(roundToDecimalPlaces(value: distance, decimalPlaces: 2)) km"
        durationLabel.text = "Duration: \(roundToDecimalPlaces(value: duration, decimalPlaces: 2)) min"
        speedLabel.text = "Speed: \(roundToDecimalPlaces(value: speed, decimalPlaces: 2)) km/h"
        showStatLabels()*/
    }
    
    
    /*func calculateDistance() -> Double {
        activityRecorder.saveToLocalStorage()
        
        var calculatedDistance: Double = 0.0
        
        var lastLat = latToKm(lat: coordinates[0][0])
        var lastLong = longToKm(lat: coordinates[0][0], long: coordinates[0][1])
        
        for i in 1...coordinates.count - 1 {
            let coordinate = coordinates[i]
            
            let lat = coordinate[0]
            let long = coordinate[1]
            let latKm = latToKm(lat: lat)
            let longKm = longToKm(lat: lat, long: long)
            
            let latDifference = latKm - lastLat
            let longDifference = longKm - lastLong
            
            let currentDistance = sqrt(pow(latDifference, 2) + pow(longDifference, 2))
            print(lastLat, lastLong, latDifference, longDifference, currentDistance)
            calculatedDistance += currentDistance
            
            lastLat = latKm
            lastLong = longKm
        }
        
        return calculatedDistance
    }
    
    
    func latToKm(lat: Double) -> Double {
        return lat * 110.574
    }
    
    func longToKm(lat: Double, long: Double) -> Double {
        return long * 111.320 * cos(lat)
    }
    
    
    func calculateDuration() -> Double {
        let startTime = coordinates[0][2]
        let stopTime = coordinates[coordinates.count - 1][2]
        let calculatedDuration: Double = (stopTime - startTime) / 60
        return calculatedDuration
    }
    
    func calculateSpeed(distance: Double, duration: Double) -> Double {
        let calculatedSpeed: Double = distance / (duration / 60)
        return calculatedSpeed
    }
    
    
    func roundToDecimalPlaces(value: Double, decimalPlaces: Int) -> Double {
        let decimalValue = pow(10, Double(decimalPlaces))
        var roundedValue = value * decimalValue
        roundedValue.round()
        roundedValue = roundedValue / decimalValue
        return roundedValue
    }*/
    
}

