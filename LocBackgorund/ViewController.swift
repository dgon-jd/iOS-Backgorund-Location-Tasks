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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAutoUpload()
  
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupAutoUpload() {
    locationService.locationChanged = {
      print("[LOG] uploading something]")
    }
    
    locationService.statusChanged = {
      print("[LOG] location service status changed")
    }
  }

}

