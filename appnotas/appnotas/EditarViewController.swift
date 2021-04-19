//
//  EditarViewController.swift
//  appnotas
//
//  Created by JORGE LUIS BALTAZAR PEREZ on 19/04/21.
//

import UIKit

class EditarViewController: UIViewController {
    var notas:[String]?
    var posicion: Int?
    let defaultDB = UserDefaults.standard
    var recibirNota:String?

    @IBOutlet weak var editarNotaTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        editarNotaTextField.text = recibirNota

        // Do any additional setup after loading the view.
    }
    
    @IBAction func guardarButton(_ sender: Any) {
        notas?.remove(at: posicion!)
        
        
        if let notaEditada = editarNotaTextField.text{
            notas?.append(notaEditada)
        }
        
        
        //notas?.append(editarNotaTextField.text ?? "Vacio")
        defaultDB.set(notas,forKey: "notas")
        navigationController?.popToRootViewController(animated: true)
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
