//
//  ViewController.swift
//  AppFinal
//
//  Created by Yu on 26/05/22.
//

import UIKit


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagenesCajas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        as! CollectionViewCell
        cell.ivCaja.image = UIImage(named: imagenesCajas[indexPath.row])
        cell.nameCaja.text = imagenesCajas[indexPath.row]
        cell.layer.cornerRadius = 20
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let vc = segue.destination as! SecondViewController
    
       
    }
    
    var imagenesCajas = ["itachi","naruto","sakura","kakashi","minato","sasuke"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yuu Ritzy"
        
        // Do any additional setup after loading the view.
    }


}

