//
//  DataModel.swift
//  AppFinal
//
//  Created by Yu on 26/06/22.
//

import UIKit

/*enum PokemonType: String {
  case ghost
  case poisson
  case psychic
  case electric
  case grass
  case fire
  case fairy

  var name: String {
      get { return String(describing: self) }
  }
}*/

struct Personaje {
    let name: String
    let photo: UIImage
   let stars : Double
}

class DataSet {
  
    private let data = ["itachi","naruto","sakura","kakashi","minato","sasuke"]
    private let stars = [4.9,4.8,4.5,4.8,4.5,4.7]
    var personajes: [Personaje] = []
  
func generateData() {
    for personaje in data {
        let image =  UIImage(named: personaje.lowercased()) ?? UIImage()
        let numstar = stars[data.firstIndex(of: personaje)!]
        print(numstar)
        let newPersonaje =  Personaje(name: personaje, photo: image, stars: numstar)
        personajes.append(newPersonaje)
    }
  }
}
