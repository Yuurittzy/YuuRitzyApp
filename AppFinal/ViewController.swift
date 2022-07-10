//
//  ViewController.swift
//  AppFinal
//
//  Created by Yu on 26/05/22.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
//    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var collectionV: UICollectionView!
    
    let datos = DataSet()
    var admUbicacion = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yuu Ritzy"
        datos.generateData()
        //PARA UBICACION
        admUbicacion.desiredAccuracy = kCLLocationAccuracyHundredMeters
        admUbicacion.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Verificamos si la geolocalización está activada
        if CLLocationManager.locationServicesEnabled() {
            switch admUbicacion.authorizationStatus {
                case .notDetermined: admUbicacion.requestAlwaysAuthorization()
                case .restricted:
                    let alert = UIAlertController(title: "Error", message: "Permite utilizar su ubicación actual para envío?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "SI", style: UIAlertAction.Style.default, handler: { action in
                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                        if UIApplication.shared.canOpenURL(settingsUrl) {
                            UIApplication.shared.open(settingsUrl, options: [:],completionHandler:nil)
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                default: admUbicacion.startUpdatingLocation()
            }
        }
        else {
            // ?
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        datos.personajes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        as! CollectionViewCell
        cell.nameCaja.text = datos.personajes[indexPath.row].name.capitalized
        cell.ivCaja.image = datos.personajes[indexPath.row].photo
        cell.layer.cornerRadius = 20
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SecondViewController
        if let index = collectionV.indexPathsForSelectedItems?.first?.row {
            let elPersonaje = datos.personajes[index]
            vc.personaje = elPersonaje
        }
       
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            admUbicacion.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // solo se necesitaba una ubicación?
        admUbicacion.stopUpdatingLocation()
        // que hacemos con la ubicación?
        // las ubicaciones obtenidas se ordenan de la mejor a la peor, asi que tomamos la primera
        guard let ubicacion = locations.first else { return }
        print ("\(ubicacion.coordinate.latitude), \(ubicacion.coordinate.longitude)")
        CLGeocoder().reverseGeocodeLocation(ubicacion) { lugares, error in
           // var direccion = ""
            if error != nil {
                print ("no se pudo encontrar la dirección correspondiente a esa coordenada")
            }
            else {
                guard let lugar = lugares?.first else { return }
                let thoroughfare = (lugar.thoroughfare ?? "") //calle
                let subThoroughfare = (lugar.subThoroughfare ?? "") // num
                let locality = (lugar.locality ?? "") //cd
                let subLocality = (lugar.subLocality ?? "")//col
                let administrativeArea = (lugar.administrativeArea ?? "")//edo
                let subAdministrativeArea = (lugar.subAdministrativeArea ?? "")//cd
                let postalCode = (lugar.postalCode ?? "")
                let country = (lugar.country ?? "")
                self.lblLocation.text = "¿Compras desde \(subAdministrativeArea) ... \(postalCode)"
                print( "Dirección: \(thoroughfare) \(subThoroughfare) \(locality) \(subLocality) \(administrativeArea) \(subAdministrativeArea) \(postalCode) \(country)")
                if (Persist().obtenerDireccion().count == 0){
                    Persist().guardaDireccion(thoroughfare, subThoroughfare, subLocality, postalCode, subAdministrativeArea)
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Que sigue?
        // no se pueden obtener lecturas que cumplan con la precisión deseada
        admUbicacion.stopUpdatingLocation()
    }
}
  




