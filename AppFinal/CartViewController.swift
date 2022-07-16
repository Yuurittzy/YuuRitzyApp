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
    var arrayQuantity = [Int]()
    let envioCosto = 50
    var totalAPagar = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Carrito"
        arrayQuantity = [Int](repeating: 1, count: 6)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let dir = Persist().obtenerDireccion().first
        adress.text = "Envío a \(dir!.delegacion ?? "") ... \(dir!.cp ?? "")"
        carrito = Persist().obtenerCart()
        totalFun()
        collectionVieww.reloadData()
        if (carrito.count == 0 ){
            btnComprar.isEnabled = false
        }else {
            btnComprar.isEnabled = true
        }
        

    }
    
    @IBOutlet weak var collectionVieww: UICollectionView!
    
    @IBAction func comprar(_ sender: Any) {
        
        let fullMob = "525522958650"
                let urlWhats = "whatsapp://send?phone=\(fullMob)&text=\(mensaje())"
                if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
                    
                    if let whatsappURL = NSURL(string: urlString) {
                        if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                            UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
                                if Bool {
                                    print("action executed succsessfully")
                                }
                                else {
                                    print(Bool)
                                }
                                
                            })
                        } else {
                            print("WhatsApp Not Found on your device")
                        }
                    }
                }
    }
    
    
    @IBOutlet weak var btnComprar: UIButton!
    @IBOutlet weak var ceroCero: UILabel!
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
        cell.btnMinus.tag = indexPath.row
        cell.btnPlus.tag = indexPath.row
        cell.quantity.text = String(arrayQuantity[indexPath.row])
        cell.btnMinus.addTarget(self, action: #selector(buttonActionMin), for: .touchUpInside)
        cell.btnPlus.addTarget(self, action: #selector(buttonActionPlus), for: .touchUpInside)
        return cell
            
    }
    
    @objc func buttonActionMin(sender: UIButton!) {
        
        if (arrayQuantity[sender.tag] >= 1 ){
            arrayQuantity[sender.tag] -= 1
          //  collectionVieww.reloadData()
        }
        if (arrayQuantity[sender.tag] == 0){
            arrayQuantity[sender.tag] = 1
            borrarDelCart(sender.tag)
        }
        carrito = Persist().obtenerCart()
        collectionVieww.reloadData()
        totalFun()
        
    }
    
    @objc func buttonActionPlus(sender: UIButton!) {
        arrayQuantity[sender.tag] += 1
        carrito = Persist().obtenerCart()
        totalFun()
        collectionVieww.reloadData()
    }
    
    func borrarDelCart(_ ind :Int) {
        Persist().borrarCart(ind)
    }
    
    func totalFun(){
       var aux = 0
        if (carrito.count != 0){
            for i in 0...carrito.count-1 {
                print(i)
                aux += Int(carrito[i].preciofinal) * arrayQuantity[i]
                print(aux)
            }
                total.text = "$ " + String(aux + envioCosto)
                ceroCero.text="00"
                totalAPagar = aux + envioCosto
        }else {
            total.text = " "
            ceroCero.text=" "
            btnComprar.isEnabled = false
            totalAPagar = 0
        }
       
    }
     
    func mensaje() -> String {
        let arrayCart = Persist().obtenerCart()
        var aux = "Hola, buen día, me gustaría comprar: \n \n"
        var cajax = "Caja"
        for i in 0...arrayCart.count-1 {
            if (arrayQuantity[i] > 1){
                cajax = "Cajas"
            }
            else{
                cajax = "Caja"
            }
            aux += "\(arrayQuantity[i]) " + cajax + " de \(arrayCart[i].nombre!.capitalized) \n"
        }
        print(aux)
        aux += "\n Con un costo total de *$\(totalAPagar)*, incluyendo envío \n"
        var auxdir = "\n *A la dirección* \n"
        if (Persist().obtenerDireccion().count != 0){
            let arrayDir = Persist().obtenerDireccion().first
            auxdir += "Calle: " + arrayDir!.calle! + " Núm: " + arrayDir!.numCalle! + "\n Colonia: " + arrayDir!.colonia! + "\n CP: " + arrayDir!.cp! + "\n Delegacion/municipio: " + arrayDir!.delegacion! + "\n Estado: " + arrayDir!.estado!
        } else{
            auxdir = " "
        }
        print(aux + auxdir)
        return aux + auxdir
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
