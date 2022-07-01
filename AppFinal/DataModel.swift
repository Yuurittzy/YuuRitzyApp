//
//  DataModel.swift
//  AppFinal
//
//  Created by Yu on 26/06/22.
//

import UIKit
//import CoreData

struct Personaje {
    let name: String
    let photo: UIImage
    let stars : Double
    let price : Int
    let discount: Int
}

class DataSet {
    
    //PASOS PARA PERSISTENCIA
   
    
    
    //SE CONFIGURAN LOS DATOS DE LOS ARTICULOS
  
    private let data = ["itachi","naruto","sakura","kakashi","minato","sasuke"]
    private let stars = [4.9,4.8,4.5,4.8,4.5,4.7]
    private let price = [1100,1100,1100,1100,1100,1100]
    private let discount = 10
    var personajes: [Personaje] = []
  
func generateData() {
    for personaje in data {
        let image =  UIImage(named: personaje.lowercased()) ?? UIImage()
        let numstar = stars[data.firstIndex(of: personaje)!]
        let price = price[data.firstIndex(of: personaje)!]
        let newPersonaje =  Personaje(name: personaje, photo: image, stars: numstar, price: price, discount: discount)
        personajes.append(newPersonaje)
    }
  }
}
