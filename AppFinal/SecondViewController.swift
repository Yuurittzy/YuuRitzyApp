//
//  SecondViewController.swift
//  AppFinal
//
//  Created by Yu on 28/05/22.
//

import UIKit
import Cosmos

class SecondViewController: UIViewController {
    
    @IBOutlet weak var titleCajaDe: UILabel!
    @IBOutlet weak var starsRating: CosmosView!
    
    var personaje : Personaje?

    override func viewDidLoad() {
        super.viewDidLoad()
        title="Yuu Ritzy"
        starsRating.rating = personaje!.stars
        titleCajaDe.text = "Caja sorpresa con \n temática de " + personaje!.name.capitalized
        // Do any additional setup after loading the view.
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
