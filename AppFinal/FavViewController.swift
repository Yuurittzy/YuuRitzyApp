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
        let tap = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.tappedMe))
        direction.addGestureRecognizer(tap)
        direction.isUserInteractionEnabled = true
    }
    @objc func tappedMe()
    {
    
    }
    override func viewWillAppear(_ animated: Bool) {
        persist = Persist().obtenerFav()
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
            return cell
        }
        
       return cell
        
         
        
    }
    
    
    
    

  //  @IBOutlet weak var navBar: UINavigationBar!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
