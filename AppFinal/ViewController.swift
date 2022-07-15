//
//  ViewController.swift
//  AppFinal
//
//  Created by Yu on 26/05/22.
//

import UIKit
import CoreLocation
import Network

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var collectionV: UICollectionView!
    
    let datos = DataSet()
    var admUbicacion = CLLocationManager()
    var internetStatus = false
    var internetType = ""
    var aux = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yuu Ritzy"
        datos.generateData()
        //PARA UBICACION
        admUbicacion.desiredAccuracy = kCLLocationAccuracyHundredMeters
        admUbicacion.delegate = self
        //PARA VERIFICAR ACCESO A INTERNET
        let monitor = NWPathMonitor()
              monitor.pathUpdateHandler = { path in
                  if path.status != .satisfied {
                      self.internetStatus = false
                  }
                  else {
                      self.internetStatus = true
                      if path.usesInterfaceType(.wifi) {
                          self.internetType = "Wifi"
                      }
                      else if path.usesInterfaceType(.cellular) {
                          self.internetType = "Cellular"
                      }
                  }
              }
              monitor.start(queue: DispatchQueue.global())
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if (!(internetStatus) && aux == 0 ){
                    let alert = UIAlertController(title: "No se puede acceder a la ubicación", message: "No hay conexión a internet", preferredStyle: .alert)
                    let boton = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(boton)
                    self.present(alert, animated:true)
                    Persist().guardaDireccion("", "", "", "", "", "")
                    aux = 1 //permite que la alerta solo se muestre una vez
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if internetStatus {
            if CLLocationManager.locationServicesEnabled() {
                switch admUbicacion.authorizationStatus {
                    case .notDetermined: admUbicacion.requestAlwaysAuthorization()
                    case .restricted:
                        let alert = UIAlertController(title: "Error", message: "¿Desea utilizar su ubicación actual para envío?", preferredStyle: UIAlertController.Style.alert)
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
                Persist().guardaDireccion("", "", "", "", "", "")
            }
            if (Persist().obtenerDireccion().count == 1){
                let dir = Persist().obtenerDireccion().first
                lblLocation.text = "¿Compras desde \(dir!.delegacion ?? "") ... \(dir!.cp ?? "") ?"
            }
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
        CLGeocoder().reverseGeocodeLocation(ubicacion) { lugares, error in
           // var direccion = ""
            if error != nil {
                print ("no se pudo encontrar la dirección correspondiente a esa coordenada")
            }
            else {
                guard let lugar = lugares?.first else { return }
                let thoroughfare = (lugar.thoroughfare ?? "") //calle
                let subThoroughfare = (lugar.subThoroughfare ?? "") // num
                let subLocality = (lugar.subLocality ?? "")//col
                let administrativeArea = (lugar.administrativeArea ?? "")//edo
                let subAdministrativeArea = (lugar.subAdministrativeArea ?? "")//cd
                let postalCode = (lugar.postalCode ?? "")
               // let country = (lugar.country ?? "")
                if (Persist().obtenerDireccion().count == 0){
                    self.lblLocation.text = "¿Compras desde \(subAdministrativeArea) ... \(postalCode) ?"
                    Persist().guardaDireccion(thoroughfare, subThoroughfare, subLocality, postalCode, subAdministrativeArea, administrativeArea)
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Que sigue?
        // no se pueden obtener lecturas que cumplan con la precisión deseada
        admUbicacion.stopUpdatingLocation()
        Persist().guardaDireccion("", "", "", "", "", "")
        
    }
}
  




