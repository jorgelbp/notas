//
//  ViewController.swift
//  appnotas
//
//  Created by JORGE LUIS BALTAZAR PEREZ on 18/04/21.
//

import UIKit

class ViewController: UIViewController{
    
    var posicion: Int?
    
    let defaultDB = UserDefaults.standard
    
    var notas = ["super","estudiar","serie","fumar"]
    
    var notaEditar: String?
   
    

    @IBOutlet weak var tablaNotas: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tablaNotas.delegate=self
        tablaNotas.dataSource=self
        
   
        
        if let arregloNotas = defaultDB.array(forKey: "notas") as? [String]{
            notas = arregloNotas
        } 
       print(defaultDB.array(forKey: "notas"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let arregloNotas = defaultDB.array(forKey: "notas") as? [String]{
            notas = arregloNotas
        }
        tablaNotas.reloadData()
        print("appear")
    }


    @IBAction func addNotaButton(_ sender: Any) {
        
        var textField = UITextField()
        
        let alerta = UIAlertController(title: "agregar nuevo", message: "nueva nota", preferredStyle: .alert)
        
        let accion = UIAlertAction(title: "aceptar", style: .default) { (_) in
            print("nota agregada")}
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alerta.addAction(accionCancelar)
        alerta.addAction(accion)
        
        alerta.addTextField { (textFieldAlerta) in textFieldAlerta.placeholder = "agregar nota..."
            textField = textFieldAlerta
            self.notas.append(textField.text ?? "valor vacio")
            self.defaultDB.set(self.notas, forKey: "notas")
            self.tablaNotas.reloadData()
            
        }
        
        present(alerta, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    //llenar
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNotas.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        celda.textLabel?.text = notas[indexPath.row]
        let fecha = Data()
        
        celda.detailTextLabel?.text = "\(fecha)"
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(notas[indexPath.row])
        posicion = indexPath.row
        notaEditar = notas[indexPath.row]
        performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            let objEditar = segue.destination as! EditarViewController
            objEditar.recibirNota = notaEditar
            objEditar.notas = notas
            objEditar.posicion = posicion
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           // objects.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
            notas.remove(at: indexPath.row)
           
            tablaNotas.reloadData()
            self.defaultDB.set(self.notas, forKey: "notas")
        }
    }
    
}
