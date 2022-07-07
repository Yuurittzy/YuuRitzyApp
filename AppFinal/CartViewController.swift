//
//  CartViewController.swift
//  AppFinal
//
//  Created by Yu on 27/05/22.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
 //   var personaje : Personaje?
    let persistencia = Persist()
    var carrito: [Carrito] = []
    var cantidad : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Carrito"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        carrito = Persist().obtenerCart()
        collectionVieww.reloadData()
    
    }
    
    
    @IBOutlet weak var collectionVieww: UICollectionView!
  /*  @IBAction func clickMinus(_ sender: Any) {
        cantidad -= 1
        collectionVieww.reloadData()
        
    }
    @IBAction func clickPlus(_ sender: Any) {
        cantidad += 1
        collectionVieww.reloadData()
     //   total.text = String(cantidad*noestaguardado())
    }*/
    
    @IBAction func comprar(_ sender: Any) {
    }
    
    
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var total: UILabel!
    
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carrito.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCart", for: indexPath)
            as! CollectionViewCellCart
        carrito = Persist().obtenerCart()
        let persists = carrito[indexPath.row]
        cell.ivCart.image = UIImage(named: persists.nombre!.lowercased())
        cell.boxOf.text = "Caja sorpresa con temática de " + persists.nombre!
        cell.price.text = "$ " + String(persists.preciofinal)
        cell.quantity.text = String(persists.cantidad)
        cell.btnMinus.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return cell
    }
    
    @objc func buttonAction(sender: UIButton!) {
             print("Button Clicked")
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
