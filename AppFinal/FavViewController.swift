//
//  FavViewController.swift
//  AppFinal
//
//  Created by Yu on 27/05/22.
//

import UIKit


class FavViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var direction: UILabel!
    @IBOutlet weak var collectionVieww: UICollectionView!
    var persist: [Favoritos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoritos"
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        persist = Persist().obtenerFav()
        let auxdir = Persist().obtenerDireccion()
        if ( auxdir.count > 0){
        let dir = auxdir.first
        direction.text = "¿Compras desde \(dir!.delegacion ?? "") ... \(dir!.cp ?? "") ?"
        }
        collectionVieww.reloadData()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persist.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFav", for: indexPath)
            as! CollectionViewCellFav
        persist = Persist().obtenerFav()
        let persists = persist[indexPath.row]
        
        if (persists.nombre != nil){
            
            cell.ivCaja.image = UIImage(named: persists.nombre!.lowercased())
            cell.boxOf.text = "Caja sorpresa con temática de " + persists.nombre!
            cell.price.text = "$ " + String(persists.precioFinal)
            cell.stars.rating = persists.calificacion
            cell.btnfav.tag = indexPath.row
            cell.btnfav.addTarget(self, action: #selector(clickUnFav), for: .touchUpInside)
            cell.addToCart.tag = indexPath.row
            cell.addToCart.addTarget(self, action: #selector(clickAddCart), for: .touchUpInside)
            return cell
        }
       return cell
        
    }
    
    @objc func clickUnFav(sender: UIButton!) {
        
        Persist().borrar(sender.tag)
        persist = Persist().obtenerFav()
        collectionVieww.reloadData()
    }
    
    @objc func clickAddCart(sender: UIButton!) {
         
        //if (persist.count != 0) {
        var flag = false
        let getCart = Persist().obtenerCart()
        persist = Persist().obtenerFav()
        let aux = persist[sender.tag]
        if (getCart.count != 0){
            for i in 0...getCart.count-1 {
                if (aux.nombre == getCart[i].nombre){
                    flag = true
                }
            }
                
       }
        if (!flag || getCart.count == 0){
                Persist().guardaEnCart(aux.nombre, Int(aux.precioFinal), 1)
                flag = false
        }
       
    }
    
}
