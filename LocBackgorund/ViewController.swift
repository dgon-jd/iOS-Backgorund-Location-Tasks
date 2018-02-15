//
//  ViewController.swift
//  LocBackgorund
//
//  Created by Dmitry Goncharenko on 2/14/18.
//  Copyright © 2018 Dmitry Goncharenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var locationService = LocationService()
  var timer = Timer()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAutoUpload()
    locationService.startSignificantChangeUpdates
  }

  func setupAutoUpload() {
    locationService.locationChanged = {
      print("[LOG] uploading something")

    }
    
    locationService.statusChanged = {
      print("[LOG] location service status changed")
    }
    
    locationService.askPermissions()
  }
  
  func runTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
  }
  @objc func updateTimer() {
    print("time")
  }
}

