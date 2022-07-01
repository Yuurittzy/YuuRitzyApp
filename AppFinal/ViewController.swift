//
//  ViewController.swift
//  AppFinal
//
//  Created by Yu on 26/05/22.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
//    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionV: UICollectionView!
    
    let datos = DataSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yuu Ritzy"
        datos.generateData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        datos.personajes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        as! CollectionViewCell
        cell.nameCaja.text = datos.personajes[indexPath.row].name.capitalized
        cell.ivCaja.image = datos.personajes[indexPath.row].photo
        cell.layer.cornerRadius = 20
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SecondViewController
        if let index = collectionV.indexPathsForSelectedItems?.first?.row {
            let elPersonaje = datos.personajes[index]
            vc.personaje = elPersonaje
        }
       
    }
    

  


}

