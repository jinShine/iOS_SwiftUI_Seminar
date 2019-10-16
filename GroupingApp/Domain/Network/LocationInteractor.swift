//
//  LocationInteractor.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/16.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

final class LocationInteractor: LocationUseCase {

  let locationManager = LocationManager()
  
  func fetch() -> Observable<LocationResponse> {
    return Observable.create { observer -> Disposable in
      
      self.locationManager.fetchWithCompletion { (location, error) in
        let type = (location, error)
        observer.onNext(type)
      }
      
      return Disposables.create()
    }
  }
  
  func start() {
    locationManager.startMonitoringUpdates()
  }
  
  func stop() {
    locationManager.stopMonitoringUpdates()
  }
  
//  func start() -> Completable {
//    return Completable.create { (completable) -> Disposable in
//      self.locationManager.startMonitoringUpdates()
//      completable(.completed)
//      return Disposables.create()
//    }
//  }
//
//  func stop() -> Completable {
//    return Completable.create { (completable) -> Disposable in
//      self.locationManager.stopMonitoringUpdates()
//      completable(.completed)
//      return Disposables.create()
//    }
//  }
}
