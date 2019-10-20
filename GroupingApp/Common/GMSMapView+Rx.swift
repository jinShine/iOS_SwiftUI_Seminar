//
//  GMSMapView+Rx.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/20.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import GoogleMaps

extension GMSMapView: HasDelegate {
    public typealias Delegate = GMSMapViewDelegate
}

class RxGMSMapViewDelegateProxy
  : DelegateProxy<GMSMapView, GMSMapViewDelegate>,
  DelegateProxyType,
  GMSMapViewDelegate {
  
  public weak private(set) var mapView: GMSMapView?
  
  init(mapView: ParentObject) {
    self.mapView = mapView
    super.init(parentObject: mapView, delegateProxy: RxGMSMapViewDelegateProxy.self)
  }
  
  static func registerKnownImplementations() {
    self.register { RxGMSMapViewDelegateProxy(mapView: $0) }
  }
  
  static func currentDelegate(for object: GMSMapView) -> GMSMapViewDelegate? {
    return object.delegate
  }
  
  static func setCurrentDelegate(_ delegate: GMSMapViewDelegate?,
                                 to object: GMSMapView) {
    object.delegate = delegate
  }
}

extension Reactive where Base: GMSMapView {
  
  var rx_delegate: DelegateProxy<GMSMapView, GMSMapViewDelegate> {
    return RxGMSMapViewDelegateProxy.proxy(for: base)
  }
  
  var didTapAt: Observable<CLLocationCoordinate2D?> {
    let source = rx_delegate
      .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapAt:)))
      .map { $0[1] as? CLLocationCoordinate2D  }
    return source
  }
  
  var didTapMarker: ControlEvent<GMSMarker> {
    let source = rx_delegate
      .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTap:)))
      .map { a in
        return try castOrThrow(resultType: GMSMarker.self, a[1])
    }
    return ControlEvent(events: source)
  }
  
  var markerInfoWindow: ControlEvent<GMSMarker> {
    let source = rx_delegate
      .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:markerInfoWindow:)))
      .map { $0[1] as! GMSMarker }
    return ControlEvent(events: source)
  }
  
  var didTapMyLocation: Observable<CLLocationCoordinate2D?> {
    let source = rx_delegate
      .methodInvoked(#selector(GMSMapViewDelegate.mapView(_:didTapMyLocation:)))
      .map { $0[1] as? CLLocationCoordinate2D  }
    return source
  }
  
}


func castOrThrow<T>(resultType: T.Type, _ object: Any) throws -> T {
  guard let returnValue = object as? T else {
    throw RxCocoaError.castingError(object: object, targetType: resultType)
  }

  return returnValue
}
