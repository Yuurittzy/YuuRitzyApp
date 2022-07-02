//
//  FavViewController.swift
//  AppFinal
//
//  Created by Yu on 27/05/22.
//

import UIKit


class FavViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var persist: [Favoritos] = []
    private let data = ["itachi","naruto","sakura","kakashi","minato","sasuke"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favoritos"
        persist = Persist().obtenerFav()
        
        // Do any additional setup after loading the view.
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("__________________")
        print(persist.count)
        //return persist.obtenerFav().count
        //return persist.count
        return persist.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFav", for: indexPath)
            as! CollectionViewCellFav
        let persists = persist[indexPath.row]
            cell.ivCaja?.image = UIImage(named: persists.nombre!.lowercased())
            cell.boxOf?.text = "Caja sorpresa con temática de " + persists.nombre!
            cell.price?.text = "$ " + String(persists.precioFinal)
            cell.stars.rating = persists.calificacion
        
        //print("__________________")
      //  print(persists.nombre!)
           
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
