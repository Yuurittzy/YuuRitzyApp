//
//  SecondViewController.swift
//  AppFinal
//
//  Created by Yu on 28/05/22.
//

import UIKit
import Cosmos

class SecondViewController: UIViewController {
    
    let persist = Persist()
    
    @IBOutlet weak var titleCajaDe: UILabel!
    @IBOutlet weak var starsRating: CosmosView!
    @IBOutlet weak var cajaPreview: UIImageView!
    @IBOutlet weak var precioViejo: UILabel!
    @IBOutlet weak var precioNuevo: UILabel!
    @IBOutlet weak var descuentoPorcentaje: UILabel!
    @IBOutlet weak var btnAgregarACarrito: UIButton!
    @IBOutlet weak var icFav: UIImageView!
    
    @IBAction func clickAgregarAlCarrito(_ sender: Any) {
        print("se agrego al carrito")
    
    }
    
    var personaje : Personaje?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title="Yuu Ritzy"
        starsRating.rating = personaje!.stars
        titleCajaDe.text = "Caja sorpresa con \n temática de " + personaje!.name.capitalized
        cajaPreview.image = UIImage(named:  personaje!.name + "Preview")
        precioViejo.text = "$ " + String(personaje!.price)
        precioNuevo.text = "$ " + String(personaje!.price - personaje!.price * personaje!.discount/100)
        descuentoPorcentaje.text = String(personaje!.discount) + "% OFF"
        // AL HACER TAP EN EL ICONO DE FAV SE CREAN LAS VARIABLES PARA FORMAR LA ACCION
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tappedMe))
        icFav.addGestureRecognizer(tap)
        icFav.isUserInteractionEnabled = true
        
    }
    
    
    @objc func tappedMe()
    {
        
        if (icFav.image == UIImage(systemName:"suit.heart.fill")){
            icFav.image = UIImage(systemName:"suit.heart")
        }else{
            
            let precioFinal = personaje!.price - personaje!.price * personaje!.discount/100
            persist.guardaEnFav(personaje!.name, personaje!.stars, precioFinal)
            icFav.image = UIImage(systemName:"suit.heart.fill")
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
