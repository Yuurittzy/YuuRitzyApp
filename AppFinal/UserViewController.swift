//
//  UserViewController.swift
//  AppFinal
//
//  Created by Yu on 27/05/22.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var direccion: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Mi cuenta"
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dir = Persist().obtenerDireccion().first
        direccion.text = "¿Compras desde \(dir!.delegacion ?? "") ... \(dir!.cp ?? "") ?"
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
