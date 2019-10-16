//
//  LocationManager.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/16.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import CoreLocation

typealias LocationDidUpdate = ((_ location: CLLocation?, _ error: Error?)->())
typealias LocationResponse = (CLLocation?, Error?)

class LocationManager: NSObject, CLLocationManagerDelegate {
  
  enum LocationError: Error {
    case authorizationDenied
  }
  
  // MARK: Properties
  var distanceFilter: CLLocationDistance {
      return kCLDistanceFilterNone
  }
  var pausesLocationUpdatesAutomatically: Bool {
      return true
  }
  class var locationServicesEnabled: Bool {
      return CLLocationManager.locationServicesEnabled()
  }
  private lazy var locationManager: CLLocationManager? = {
     return CLLocationManager()
  }()
  
  private var didUpdateLocation: LocationDidUpdate?
  var running = false
  
  override init() {
    super.init()
    checkAuthorizationStatus()
  }
  
  // MARK: Deint
  deinit {
      stopMonitoringUpdates()
  }
  
  // MARK: Location Authorization Status Changed
  private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
      switch status {
      case .authorizedWhenInUse, .authorizedAlways:
          running = true
          locationManager?.startUpdatingLocation()
      case .denied, .restricted, .notDetermined:
          didUpdateLocation?(nil, LocationError.authorizationDenied)
          running = false
          locationManager?.stopUpdatingLocation()
          log.error(LocationError.authorizationDenied)
      @unknown default:
        fatalError()
    }
  }
  
  // MARK: Location Manager Delegate
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      didUpdateLocation?(nil, error)
      log.error(error)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      let location = locations.last
      didUpdateLocation?(location, nil)
  }
  
  func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
      running = false
  }
  
  func fetchWithCompletion(completion: @escaping LocationDidUpdate) {
      //store the completion closure
    checkAuthorizationStatus()
      didUpdateLocation = completion
//      grantPermissons()
      
  }
  
  func startMonitoringUpdates() {
      //fire the location manager
      locationManager?.distanceFilter = distanceFilter
      locationManager?.desiredAccuracy = kCLLocationAccuracyBest
      locationManager?.pausesLocationUpdatesAutomatically = pausesLocationUpdatesAutomatically
      locationManager?.delegate = self
      locationManager?.startUpdatingLocation()
      running = true
  }
  
  func stopMonitoringUpdates() {
      didUpdateLocation = nil
      locationManager?.stopUpdatingLocation()
      locationManager?.allowsBackgroundLocationUpdates = false
      locationManager?.disallowDeferredLocationUpdates()
      locationManager?.delegate = nil
      running = false
  }
  
  func checkAuthorizationStatus() {
      switch CLLocationManager.authorizationStatus() {
      case .notDetermined:
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestWhenInUseAuthorization()
      case .restricted, .denied:
          break
      case .authorizedWhenInUse, .authorizedAlways:
          startMonitoringUpdates()
      @unknown default:
        return
    }
  }
  
  private func grantPermissons() {
      //check for description key and ask permissions
      if (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil) {
          locationManager?.requestAlwaysAuthorization()
      } else if (Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil) {
          locationManager?.requestWhenInUseAuthorization()
      } else if (Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysAndWhenInUseUsageDescription") != nil) {
          locationManager?.requestAlwaysAuthorization()
      }
      else {
          fatalError("To use location in iOS8 you need to define either NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription in the app bundle's Info.plist file")
      }
  }
  
}
