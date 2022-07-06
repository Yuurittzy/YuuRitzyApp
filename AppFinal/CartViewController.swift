//
//  CartViewController.swift
//  AppFinal
//
//  Created by Yu on 27/05/22.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBAction func clickMinus(_ sender: Any) {
    }
    @IBAction func clickPlus(_ sender: Any) {
    }
    @IBOutlet weak var quantity: UILabel!
    
    @IBAction func comprar(_ sender: Any) {
    }
    
    
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var total: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Carrito"
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCart", for: indexPath)
            as! CollectionViewCellCart
        cell.boxOf.text = "Caja sorpresa con temática de tangananica"
        return cell
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
