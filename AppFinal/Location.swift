//
//  Location.swift
//  AppFinal
//
//  Created by Yu on 09/07/22.
//

import Foundation
import CoreLocation
/*
class Location: NSObject, CLLocationManagerDelegate {

    var admUbicacion = CLLocationManager()

    public override init() {
        super.init()
        print ("PASO 1 XDXD")
        admUbicacion.desiredAccuracy = kCLLocationAccuracyHundredMeters
        admUbicacion.delegate = self
        if CLLocationManager.locationServicesEnabled() {
                    switch admUbicacion.authorizationStatus {
                        case .notDetermined: admUbicacion.requestAlwaysAuthorization()
                        case .restricted:
                            print("F")
                          /*  let alert = UIAlertController(title: "Error", message: "Se requiere su permiso para usar la ubicación, Autoriza ahora?", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "SI", style: UIAlertAction.Style.default, handler: { action in
                                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                                if UIApplication.shared.canOpenURL(settingsUrl) {
                                    UIApplication.shared.open(settingsUrl, options: [:],completionHandler:nil)
                                }
                            }))
                            alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)*/

                        default: admUbicacion.startUpdatingLocation()
                    }
                }
                else {
                    // ?
                }
    }
    
  



}*/
