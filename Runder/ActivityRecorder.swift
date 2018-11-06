//
//  ActivityRecorder.swift
//  Runder
//
//  Class for recording an activity
//
//  Copyright © 2018 New Image. All rights reserved.
//

import UIKit
import CoreLocation

class ActivityRecorder: NSObject {
    
    // Store coordinate structs here
    var coordinates: [coordinateData] = []
    // Are we currently recording?
    var isRecording = false
    // Time since 1970: when did the activity start?
    var startTime = 0.0
    // Is the recorder in use right now? This is also true if we paused the activity.
    var isInUse = false
    
    
    // All keys for storing data
    struct storageKeys {
        // Test key
        static let key = "key"
        // Store single Activity
        static let singleActivity = "singleActivity"
    }
    
    
    // Struct for storing coordinates
    struct coordinateData: Codable {
        var lat: Double
        var long: Double
        var alt: Double
        var timestamp: Double
    }
    
    
    // When the location did change, log the location to the coordinates array
    func locationDidChange(lat: Double, long: Double, alt: Double) {
        // If we have a running activity, save the coordinates
        if isRecording {
            // Time interval since activity started
            let t = Date().timeIntervalSince1970 - startTime
            // Append new coordinate
            coordinates.append(coordinateData(lat: lat, long: long, alt: alt, timestamp: t))
        }
    }
    
    
    // Start the activity
    func startActivity() {
        // Start recording
        isRecording = true
        // Declare that the recorder is in use
        isInUse = true
        // Set start time
        startTime = Date().timeIntervalSince1970
    }
    
    // Stop the activity
    func stopActivity() {
        // Stop recording
        isRecording = false
        // Activity stopped, we're no longer recording.
        isInUse = false
        
        calculateStats()
    }
    
    // Pause the activity
    func pauseActivity() {
        // Stop recording
        isRecording = false
    }
    
    // Resume the paused activity
    func resumeActivity() {
        // Start recording
        isRecording = true
    }
    
    
    // Calculate distance, duration and speed
    func calculateStats() {
        print("Results: distance: \(calculateDistance()) duration: \(calculateDuration())")
    }
    
    
    // Calculate distance of the current activity
    func calculateDistance() -> Double {
        // Store what we've calculated
        var calculatedDistance = 0.0
        
        print("count: \(coordinates.count)")
        
        // For each coordinate except the first one
        for i in 1...coordinates.count - 1 {
            
            // Get current and previous coordinate
            let currentCoordinate = coordinates[i]
            let previousCoordinate = coordinates[i - 1]
            
            // Current data
            let currentLat = currentCoordinate.lat
            let currentLong = currentCoordinate.long
            let currentAlt = currentCoordinate.alt
            let currentTimestamp = currentCoordinate.timestamp
            
            // Previous data
            let previousLat = previousCoordinate.lat
            let previousLong = previousCoordinate.long
            let previousAlt = previousCoordinate.alt
            let previousTimestamp = previousCoordinate.timestamp
            
            // Convert to CLLocation
            let currentCoordinateLoc = CLLocation(
                coordinate: CLLocationCoordinate2D(latitude: currentLat, longitude: currentLong),
                altitude: currentAlt,
                horizontalAccuracy: kCLLocationAccuracyBest,
                verticalAccuracy: kCLLocationAccuracyBest,
                timestamp: Date(timeIntervalSince1970: currentTimestamp)
            )
            
            let previousCoordinateLoc = CLLocation(
                coordinate: CLLocationCoordinate2D(latitude: previousLat, longitude: previousLong),
                altitude: previousAlt,
                horizontalAccuracy: kCLLocationAccuracyBest,
                verticalAccuracy: kCLLocationAccuracyBest,
                timestamp: Date(timeIntervalSince1970: previousTimestamp)
            )
            
            // Get distance
            let distance = currentCoordinateLoc.distance(from: previousCoordinateLoc)
            
            print("dist: \(distance)")
            
            // Add distance to total
            calculatedDistance += distance
        }
        
        print("final: \(calculatedDistance)")
        
        // Return calculated value
        return calculatedDistance;
    }
    
    
    // Calculate duration of the current activity
    func calculateDuration() -> Double {
        // Get first and last coordinate
        let firstCoordinate = coordinates[0]
        let lastCoordinate = coordinates[coordinates.count - 1]
        
        // Get first and last timestamp
        let firstTimestamp = firstCoordinate.timestamp
        let lastTimestamp = lastCoordinate.timestamp
        
        // Calculate duration
        let calculatedDuration = lastTimestamp - firstTimestamp
        // Return calculated duration
        return calculatedDuration
    }
    
    
    // Calculate speed of the current activity
    func calculateSpeed(distance dist: Double, duration dur: Double) -> Double {
        let calculatedSpeed = 0.0
        return calculatedSpeed
    }
    
    
    // Save the current activity to local storage
    func saveToLocalStorage() {
        // Load UserDefaults
        let defaults = UserDefaults.standard
        // Set the test key to "Hello world!"
        defaults.set("Hello world!", forKey: storageKeys.key)
        // print the test key value
        if let testString = defaults.string(forKey: storageKeys.key) {
            print(testString)
        }
    }
    
}
