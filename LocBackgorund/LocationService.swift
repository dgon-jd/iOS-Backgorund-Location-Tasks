//
//  ImageLocation.swift
//  LocBackgorund
//
//  Created by Dmitry Goncharenko on 2/14/18.
//  Copyright © 2018 Dmitry Goncharenko. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject {
  let locationManager = CLLocationManager()
  var firstChangeAuthDone: Bool = false
  var locationChanged: (() -> Void)?
  var statusChanged: (() -> Void)?
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }
  
  func askPermissions() {
    // TODO: add permission checks
      locationManager.requestAlwaysAuthorization()
  }
  
  func startSignificantChangeUpdates() {
    
    locationManager.startUpdatingLocation()
    
  }
//
  func stopSignificantChangeUpdates() {
    locationManager.stopUpdatingLocation()
  }
}

extension LocationService: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      if let action = locationChanged  {
        action()
      }
      print("[LOG]: update locationManager: latitude :\(location.coordinate.latitude), longitude: \(location.coordinate.longitude)")
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    if let action = statusChanged {
      action()
    }
    print("[LOG]: locationManager did fail with error \(error.localizedDescription)")
  }
}
