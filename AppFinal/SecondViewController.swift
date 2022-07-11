//
//  SecondViewController.swift
//  AppFinal
//
//  Created by Yu on 28/05/22.
//

import UIKit
import Cosmos

class SecondViewController: UIViewController {
    
    var personaje : Personaje?
    let persist = Persist()
    var items: [Favoritos] = []
    var itemsCart: [Carrito] = []
    
    @IBOutlet weak var titleCajaDe: UILabel!
    @IBOutlet weak var starsRating: CosmosView!
    @IBOutlet weak var cajaPreview: UIImageView!
    @IBOutlet weak var precioViejo: UILabel!
    @IBOutlet weak var precioNuevo: UILabel!
    @IBOutlet weak var descuentoPorcentaje: UILabel!
    @IBOutlet weak var btnAgregarACarrito: UIButton!
    @IBOutlet weak var icFav: UIImageView!
    @IBOutlet weak var direccion: UILabel!
    
    @IBAction func clickAgregarAlCarrito(_ sender: Any) {
        print("se agrego al carrito")
        if (noEstaGuardadoEnCarrito() == -1 || itemsCart.count == 0){
            let precioFinal = personaje!.price - personaje!.price * personaje!.discount/100
            persist.guardaEnCart(personaje!.name, precioFinal, 1)
            print("c guardo en carrito")
        }
    
    }
    


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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dir = Persist().obtenerDireccion().first
        direccion.text = "¿Compras desde \(dir!.delegacion ?? "") ... \(dir!.cp ?? "") ?" 
        // AL HACER TAP EN EL ICONO DE FAV SE CREAN LAS VARIABLES PARA FORMAR LA ACCION
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tappedMe))
        icFav.addGestureRecognizer(tap)
        icFav.isUserInteractionEnabled = true
        items = persist.obtenerFav()
        itemsCart = persist.obtenerCart()
        if (noestaguardado() == -1){
            icFav.image = UIImage(systemName:"suit.heart")
        }else { icFav.image = UIImage(systemName:"suit.heart.fill")}
    }
    
    
    
    
    @objc func tappedMe(){
        if (icFav.image == UIImage(systemName:"suit.heart")){
            icFav.image = UIImage(systemName:"suit.heart.fill")
            let precioFinal = personaje!.price - personaje!.price * personaje!.discount/100
            if (noestaguardado() == -1 || items.count == 0){
                persist.guardaEnFav(personaje!.name, personaje!.stars, precioFinal)
            }
        } else if (icFav.image == UIImage(systemName:"suit.heart.fill")){
            icFav.image = UIImage(systemName:"suit.heart")
            if (noestaguardado() != -1) {
                persist.borrar(noestaguardado())
               print("corazon lleno y guardado")
            }
        }
            
    }
    
    func noestaguardado() -> Int {
        for item in items {
            if(item.nombre! == personaje!.name){
                return items.firstIndex(of: item)!
            }
        }
        return -1
    }
    
    func noEstaGuardadoEnCarrito() -> Int {
        for item in itemsCart {
            if(item.nombre! == personaje!.name){
                return itemsCart.firstIndex(of: item)!
            }
        }
        return -1
    }
    
    
}
    
