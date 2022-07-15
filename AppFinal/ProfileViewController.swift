//
//  ProfileViewController.swift
//  AppFinal
//
//  Created by Yu on 11/07/22.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var ivPhoto: UIImageView!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var navItem: UINavigationItem!
    var auxPhoto: Data!
    var auxNombre : String!
    var k = true
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let obtenerPersona = Persist().obtenerPersona()
        
        if (obtenerPersona.count > 0 && k){
            tfName.text = obtenerPersona[0].nombre
            let persona = Persist().obtenerPersona().first
            ivPhoto.image = UIImage(data: (persona?.foto)!)
        }
    }
    
    @IBAction func tomarFoto(_ sender: Any) {
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            ipc.sourceType = .camera
            let permisos = AVCaptureDevice.authorizationStatus(for: .video)
            if permisos == .authorized {
                            self.present(ipc, animated: true,  completion: nil)
            }
            else {
                    if permisos == .notDetermined {
                        AVCaptureDevice.requestAccess(for: .video) { respuesta in
                            if respuesta {
                                print("ok")
                             //  self.present(ipc, animated: true,  completion: nil)
                            }
                            else {
                            print ("Acceso denegado")
                            }
                        }
                    }
                    else {  // .denied
                            let alert = UIAlertController(title: "Error", message: "Debe autorizar el uso de la cámara desde el app de configuración.", preferredStyle:.alert)
                            let btnSI = UIAlertAction(title: "Si, por favor", style: .default) { action in
                                            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                                    }
                            alert.addAction(btnSI)
                            alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.destructive, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                            
            }
        }
        else
        {
            ipc.sourceType = .photoLibrary
            self.present(ipc, animated: true,  completion: nil)
        }
    }
    
    @IBAction func escogerGalería(_ sender: Any) {
        let ipc = UIImagePickerController()
        // para trabajar con la galería
        ipc.sourceType = .photoLibrary
        ipc.delegate = self
        ipc.allowsEditing = true
        self.present(ipc, animated: true,  completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagen = info[.editedImage] as? UIImage {
            ivPhoto.image = imagen
            auxPhoto = imagen.pngData()
            k = false
            
        }
        picker.dismiss(animated:true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true, completion: nil)
    }
    
    @IBAction func guardar(_ sender: Any) {
        k=true
        if  tfName.text == ""{
            let alert = UIAlertController(title: "No ha introducido ningún nombre", message: "Introduce un nombre", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }else {
            if (auxPhoto != nil) {
                auxNombre = tfName.text
                if (Persist().obtenerPersona().count == 0) {
                    Persist().guardaPersona(auxNombre, auxPhoto)
                } else {
                    Persist().borrarPersona()
                    Persist().guardaPersona(auxNombre, auxPhoto)
            }
                let alert = UIAlertController(title: "Se guardaron los datos", message: "con éxito", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
    }
   
}
