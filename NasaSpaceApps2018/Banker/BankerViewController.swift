//
//  BankerViewController.swift
//  NasaSpaceApps2018
//
//  Created by Levy Cristian  on 20/10/18.
//  Copyright © 2018 Levy Cristian . All rights reserved.
//

import UIKit

class BankerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var itens = ["oi", "oi", "oi"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "BankerCellTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "bankerCell")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItem(_ sender: Any) {
        creatAlert()
    }
    
    func creatAlert(){
        let alert = UIAlertController(title: "Add item to banker", message: "Enter a name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
             textField.placeholder = "Input your name here..."
        }
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            guard let text = textField.text else {return}
            self.itens.append(text)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
extension BankerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankerCell", for: indexPath) as! BankerCellTableViewCell
        cell.information.text = itens[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .normal, title: "Details") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
        }
        editAction.backgroundColor = .blue
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            self.itens.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            print(self.itens)
        }

        return [editAction,deleteAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
