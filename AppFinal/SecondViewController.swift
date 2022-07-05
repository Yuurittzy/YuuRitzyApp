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
    var items: [Favoritos] = []
    
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

        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "$ " + String(personaje!.price))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        
        starsRating.rating = personaje!.stars
        titleCajaDe.text = "Caja sorpresa con \n temática de " + personaje!.name.capitalized
        cajaPreview.image = UIImage(named:  personaje!.name + "Preview")
        precioViejo.attributedText = attributeString
        precioNuevo.text = "$ " + String(personaje!.price - personaje!.price * personaje!.discount/100)
        descuentoPorcentaje.text = String(personaje!.discount) + "% OFF"
        
        
        // AL HACER TAP EN EL ICONO DE FAV SE CREAN LAS VARIABLES PARA FORMAR LA ACCION
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tappedMe))
        icFav.addGestureRecognizer(tap)
        icFav.isUserInteractionEnabled = true
        items = persist.obtenerFav()
        if yaestaguardado() {
            icFav.image = UIImage(systemName:"suit.heart")
        }else { icFav.image = UIImage(systemName:"suit.heart.fill")}
        
    }
    
    
    @objc func tappedMe(){
        if (icFav.image == UIImage(systemName:"suit.heart")){
            icFav.image = UIImage(systemName:"suit.heart.fill")
            let precioFinal = personaje!.price - personaje!.price * personaje!.discount/100
            if (yaestaguardado() || items.count == 0){
                persist.guardaEnFav(personaje!.name, personaje!.stars, precioFinal)
            } else if (yaestaguardado() && icFav.image == UIImage(systemName:"suit.heart.fill")) {
           //     icFav.image = UIImage(systemName:"suit.heart")
               print("corazon lleno y guardado")
            }
        }
            
    }
    
    func yaestaguardado() -> Bool {
        for item in items {
            print ("entro al for")
            if(item.nombre! == personaje!.name){
                print ("ya esta guardado")
               return false
            }
        }
        print ("no esta guardado")
        return true
    }
    
}
    
