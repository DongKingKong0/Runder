//
//  ActivityOverviewController.swift
//  Runder
//
//  Copyright © 2018 New Image. All rights reserved.
//

import UIKit

class ActivityOverviewController: UITableViewController {
    
    let fruits = ["Apple", "Orange", "Peach"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "overviewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier:reuseIdentifier, for: indexPath)
        
        let fruit = fruits[indexPath.row]
        
        cell.textLabel?.text = "Section \(indexPath.section), Row \(indexPath.row): \(fruit)"
        
        return cell
    }
    
    /*
     let fruits = ["Apple", "Orange", "Peach"]
     
     // Anzahl der Abschnitte (kann entfallen wenn nur ein Tabellenabschnitt benötigt wird)
     override func numberOfSections(in tableView: UITableView) -> Int {
     return 1
     }
     
     // Anzahl der Zeilen für einen bestimmten Abschnitt
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
     }
     
     // Optional: Überschriften für die Tabellenabschnitte
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     return "Section \(section)"
     }
     
     // Die tableView(cellForRowAt:)-Methode wird aufgerufen, um UITableViewCell-Objekte
     // für sichtbare Tabellenzellen zu erzeugen
     override func tableView(_ tableView: UITableView,
     cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     // Mit dequeueReusableCell werden Zellen gemäß der im Storyboard definierten Prototypen erzeugt
     let cell = tableView.dequeueReusableCell(withIdentifier:"TextCell", for: indexPath)
     
     // Dafür wird der Abschnitts- und Zeilenindex in einem IndexPath-Objekt übergeben
     let fruit = fruits[indexPath.row]
     
     // Zelle konfigurieren
     cell.textLabel?.text = "Section \(indexPath.section), Row \(indexPath.row): \(fruit)"
     
     return cell
     }
     */
    
}

