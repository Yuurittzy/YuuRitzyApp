//
//  UserViewController.swift
//  AppFinal
//
//  Created by Yu on 27/05/22.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var direccion: UILabel!

    @IBOutlet weak var lblHola: UILabel!
    @IBOutlet weak var ivUser: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mi cuenta"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let auxdir = Persist().obtenerDireccion()
        if (auxdir.count != 0){
        let dir = auxdir.first
        direccion.text = "¿Compras desde \(dir!.delegacion ?? "") ... \(dir!.cp ?? "") ?"
        }
      
        if (Persist().obtenerPersona().count != 0)
        {
            ivUser.layer.cornerRadius = self.ivUser.frame.width/2
            ivUser.clipsToBounds = true
            ivUser.layer.borderColor = UIColor.orange.cgColor
            ivUser.layer.borderWidth = 4
            let persona = Persist().obtenerPersona().first
            ivUser.image = UIImage(data: (persona?.foto)!)
            lblHola.text = "Hola, \((persona?.nombre)!)!"
        } 
        
    }
    
    @IBAction func ayuda(_ sender: Any) {
        let fullMob = "525522958650"
                let urlWhats = "whatsapp://send?phone=\(fullMob)&text=Hola, buen día. Necesito ayuda relacionada con la aplicación Yuu Ritzy "
                if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                    if let whatsappURL = NSURL(string: urlString) {
                        if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                            UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
                                if Bool {
                                    print("action executed succsessfully")
                                }
                                else {
                                    print(Bool)
                                }
                                
                            })
                        } else {
                            print("WhatsApp Not Found on your device")
                        }
                    }
                }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
