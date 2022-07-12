//
//  DirectionViewController.swift
//  AppFinal
//
//  Created by Yu on 10/07/22.
//

import UIKit

class DirectionViewController: UIViewController {

    @IBOutlet weak var lblCalle: UILabel!
    @IBOutlet weak var lblnum: UILabel!
    @IBOutlet weak var lblColonia: UILabel!
    @IBOutlet weak var lblCp: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var lblDelegación: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    @IBOutlet weak var lblPais: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="Mi Dirección"
       navItem.hidesBackButton = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configTexts()
        
    }
    
    @IBAction func clickEditar(_ sender: Any) {
        let alert = UIAlertController(title: "Cambiar dirección", message: "Introduce cuidadosamente los datos", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel, handler: nil))
               
        // Agregar text fields a un alert
               alert.addTextField(configurationHandler:{ txtCalle in
                   txtCalle.placeholder = "Calle"
               })
               alert.addTextField(configurationHandler:{ txtNumCasa in
                   txtNumCasa.placeholder = "Número"
               })
                alert.addTextField(configurationHandler:{ txtColonia in
                    txtColonia.placeholder = "Colonia"
                })
                alert.addTextField(configurationHandler:{ txtCp in
                    txtCp.placeholder = "Código Postal"
                })
                alert.addTextField(configurationHandler:{ txtDelegacion in
                    txtDelegacion.placeholder = "Delegación o Municipio"
                })
                alert.addTextField(configurationHandler:{ txtEdo in
                    txtEdo.placeholder = "Estado"
                })
               let btnEnviar = UIAlertAction(title: "Cambiar", style: .default, handler:{ action in
                   let calle = alert.textFields![0].text
                   let numCasa = alert.textFields![1].text
                   let colonia = alert.textFields![2].text
                   let cp = alert.textFields![3].text
                   let delegacion = alert.textFields![4].text
                   let estado = alert.textFields![5].text
                   Persist().borrarDir()
                   Persist().guardaDireccion(calle!, numCasa!, colonia!, cp!, delegacion!, estado!)
                   self.configTexts()
               })
               alert.addAction(btnEnviar)
               self.present(alert, animated: true, completion: nil)
    }
    
    func configTexts(){
        let direccion = Persist().obtenerDireccion()[0]
        lblCalle.text = direccion.calle
        lblnum.text = direccion.numCalle
        lblColonia.text = direccion.colonia
        lblCp.text = direccion.cp
        lblDelegación.text = direccion.delegacion
        lblEstado.text = direccion.estado
        lblPais.text = "México"
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
