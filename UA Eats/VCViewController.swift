//
//  VCViewController.swift
//  UA Eats
//
//  Created by Klenotic,Andrew on 12/10/15.
//  Copyright © 2015 Cameron Reilly. All rights reserved.
//

import Foundation
import MapKit

//extension ViewController: MKMapViewDelegate {
    //    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    //         print("Test")
    //         if let annotation = annotation as? Locations {
    //            print("Test")
    //            let identifier = "pin"
    //            var view: MKPinAnnotationView
    //            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
    //                as? MKPinAnnotationView { // 2
    //                    dequeuedView.annotation = annotation
    //                    view = dequeuedView
    //            } else {
    //                // 3
    //               view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    //                view.canShowCallout = true
    //                view.calloutOffset = CGPoint(x: -5, y: 5)
    //                view.rightCalloutAccessoryView = UIButton() as UIView
    //            }
    //            view.pinTintColor = annotation.pinColor()
    //            return view
    //        }
    //        return nil
    //    }
//}