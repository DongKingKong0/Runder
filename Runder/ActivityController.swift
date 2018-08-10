//
//  ActivityController.swift
//  Runder
//
//  Created by Lorenzo on 06.08.18.
//  Copyright © 2018 New Image. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class ActivityController: UIViewController, CLLocationManagerDelegate {
    
    var coordinates: [[Double]] = []
    var running: Bool = false
    
    var distance: Double = 0.0
    var duration: Double = 0.0
    var speed: Double = 0.0
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    
    
    @IBAction func startButtonPressed(_ sender: Any) {
        print("start")
        
        startButton.isHidden = true
        pauseButton.isHidden = false
        stopButton.isHidden = false
        
        hideStatLabels()
        
        startActivity()
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        print("stop")
        
        startButton.isHidden = false
        stopButton.isHidden = true
        pauseButton.isHidden = true
        resumeButton.isHidden = true
        
        stopActivity()
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        print("pause")
        
        pauseButton.isHidden = true
        resumeButton.isHidden = false
        
        pauseActivity()
    }
    
    @IBAction func resumeButtonPressed(_ sender: Any) {
        print("resume")
        
        resumeButton.isHidden = true
        pauseButton.isHidden = false
        
        resumeActivity()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        if running {
            coordinates.append([locValue.latitude, locValue.longitude, Date().timeIntervalSince1970])
            print("x: \(locValue.latitude) y: \(locValue.longitude)")
            print(coordinates[0])
            print(coordinates)
            print(Date().timeIntervalSince1970)
        }
        //locationLabel.text = "x: \(locValue.latitude) y: \(locValue.longitude)"
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
    
    
    func startActivity() {
        running = true
        
        resetStats()
    }
    
    func stopActivity() {
        running = false
        
        calculateStats()
        showStats()
    }
    
    func pauseActivity() {
        running = false
    }
    
    func resumeActivity() {
        running = true
    }
    
    
    func calculateStats() {
        distance = calculateDistance()
        duration = calculateDuration()
        speed = calculateSpeed(distance: distance, duration: duration)
    }
    
    func showStats() {
        distanceLabel.text = "Distance: \(roundToDecimalPlaces(value: distance, decimalPlaces: 2)) km"
        durationLabel.text = "Duration: \(roundToDecimalPlaces(value: duration, decimalPlaces: 2)) min"
        speedLabel.text = "Speed: \(roundToDecimalPlaces(value: speed, decimalPlaces: 2)) km/h"
        showStatLabels()
    }
    
    
    func resetStats() {
        distance = 0.0
        duration = 0.0
        speed = 0.0
        
        coordinates = []
    }
    
    
    func calculateDistance() -> Double {
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
    }
    
}

