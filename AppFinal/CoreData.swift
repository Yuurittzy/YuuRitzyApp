//
//  CoreData.swift
//  AppFinal
//
//  Created by Yu on 01/07/22.
//

import Foundation
import CoreData


class Persist {
    
    lazy var managedObjectModel:NSManagedObjectModel? = {
           let modelURL = Bundle.main.url(forResource:"YuuRitzyModel", withExtension: "momd")
           var model = NSManagedObjectModel(contentsOf: modelURL!)
           return model
       }()
    
    lazy var persistentStore:NSPersistentStoreCoordinator? = {
           let model = self.managedObjectModel
           if model == nil {
               return nil
           }
           let persist = NSPersistentStoreCoordinator(managedObjectModel: model!)
           let documents = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
           let urlDeLaBD = URL(fileURLWithPath:documents + "/" + "YuuRitzyModel" + ".sqlite")
           do {
               let opcionesDePersistencia = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
               try persist.addPersistentStore(ofType: NSSQLiteStoreType, configurationName:nil, at:urlDeLaBD, options:opcionesDePersistencia)
           }
           catch {
               print ("no se puede abrir la base de datos")
               // abort() // es muy dramático...
               exit(666)
           }
           return persist
       }()
        
        lazy var managedObjectContext:NSManagedObjectContext? = {
            var moc: NSManagedObjectContext?
            /*if #available(iOS 10.0, *){
                // Si es iOS 10 o posterior, los objetos NSManagedObjectModel y NSPersistentStoreCoordinator no son instanciados. En su lugar se instancia el objeto NSPersistentContainer que tiene un NSManagedObjectContext integrado, en su propiedad viewContext
                moc = self.persistentContainer.viewContext
            }
            else{ */
                // Si es iOS 9 o anterior, se deben instanciar los objetos NSManagedObjectModel y NSPersistentStoreCoordinator
                let persistence = self.persistentStore
                if persistence == nil {
                    return nil
                }
                moc = NSManagedObjectContext(concurrencyType:.privateQueueConcurrencyType)
                moc?.persistentStoreCoordinator = persistence
            //}
            return moc
        }()
    
    func guardaEnFav(_ nombre:String, _ calificacion: Double, _ precio: Int) {
           // creamos un nuevo objeto de tipo "Log"
           if let entidad = NSEntityDescription.entity(forEntityName:"Favoritos", in:managedObjectContext!) {
               let unFav = NSManagedObject(entity: entidad, insertInto: managedObjectContext!) as! Favoritos
               // asignamos sus propiedades
               unFav.nombre = nombre
               unFav.calificacion = calificacion
               unFav.precioFinal = Int16(precio)
               // guardamos el objeto
               do {
                   print("se guardo la infooooo segun xdxd")
                   try managedObjectContext?.save()
               }
               catch {
                   print ("No se puede guardar a la BD \(error.localizedDescription)")
               }
           }
       }
    
    func obtenerFav() -> [Favoritos] {
           // SELECT * FROM Log
           var resultset = [Favoritos]()
           let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoritos")
           do {
               print("se hizo el request")
               let tmp = try managedObjectContext!.fetch(request)
               resultset = tmp as! [Favoritos]
               print("____________")
               print(resultset)
           }
           catch {
               print ("fallo el request \(error.localizedDescription)")
           }
           return resultset
       }
    
}

