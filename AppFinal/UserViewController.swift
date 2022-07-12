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
        
        ivUser.layer.cornerRadius = self.ivUser.frame.width/2
        ivUser.clipsToBounds = true
        ivUser.layer.borderColor = UIColor.orange.cgColor
        ivUser.layer.borderWidth = 4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dir = Persist().obtenerDireccion().first
     
        direccion.text = "¿Compras desde \(dir!.delegacion ?? "") ... \(dir!.cp ?? "") ?"
      
        if (Persist().obtenerPersona().count != 0)
        {
              let persona = Persist().obtenerPersona().first
              ivUser.image = UIImage(data: (persona?.foto)!)
            
            lblHola.text = "Hola, \((persona?.nombre)!)!"
            
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
