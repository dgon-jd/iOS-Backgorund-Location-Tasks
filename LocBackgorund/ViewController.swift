//
//  ViewController.swift
//  LocBackgorund
//
//  Created by Dmitry Goncharenko on 2/14/18.
//  Copyright © 2018 Dmitry Goncharenko. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
  var locationService = LocationService()
  var timer = Timer()
  var latestPhotoAssetsFetched: PHFetchResult<PHAsset>? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    setupAutoUpload()
    locationService.startSignificantChangeUpdates()

  }

  
  func setupAutoUpload() {
    locationService.locationChanged = {
      if UIApplication.shared.applicationState == .background {
        print("[LOG] uploading something")
        var assets: [PHAsset] = []
        let photos = self.fetchLatestPhotos(forCount: 3)
        photos.enumerateObjects({ (asset, count, stop) in
          assets.append(asset)
        })
        self.removeAssets(assets: assets)
        print(photos)
      }
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

  func fetchLatestPhotos(forCount count: Int?) -> PHFetchResult<PHAsset> {
    // Create fetch options.
    let options = PHFetchOptions()

    // If count limit is specified.
    if let count = count { options.fetchLimit = count }

    // Add sortDescriptor so the lastest photos will be returned.
    let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
    options.sortDescriptors = [sortDescriptor]

    // Fetch the photos.
    return PHAsset.fetchAssets(with: .image, options: options)
  }

  func removeAssets(assets: [PHAsset]) {
    PHPhotoLibrary.shared().performChanges({
      PHAssetChangeRequest.deleteAssets(assets as NSArray)
    }) { success, error in
        print("Finished deleting asset \(success), \(error)")
    }
  }
}

