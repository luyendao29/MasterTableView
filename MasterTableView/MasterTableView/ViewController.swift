//
//  ViewController.swift
//  MasterTableView
//
//  Created by Boss on 9/9/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfCell: Int = 0 {
        didSet {
            title = "Số cell: \(numberOfCell)"
        }
    }
    
    var listCocktail = [CocktailModel]()
    var images = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CocktailCell", bundle: nil), forCellReuseIdentifier: "CocktailCell")
        callAPI()
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func callAPI() {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
        DataService.sharing.getAPI(url: url, completion: { data in
            if let drink = data.drinks {
                self.listCocktail = drink
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCocktail.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath) as! CocktailCell
//        if cell == nil {
//            cell = CocktailCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "CocktailCell")
//            numberOfCell += 1
//        }
        
        cell.infoCocktail = listCocktail[indexPath.row]
        cell.fillData()
        cell.passObject = { data in
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }
//        if indexPath.row % 5 == 0 {
//            cell.backgroundColor = .red
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listCocktail.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

    
    
    // di chuyển Cell Drag cell
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveTemp = listCocktail[sourceIndexPath.item]
        listCocktail.remove(at: sourceIndexPath.item)
        listCocktail.insert(moveTemp, at: destinationIndexPath.item)
    }
    
    // MARK: ACTION
    @IBAction func editAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
    }
    
}

