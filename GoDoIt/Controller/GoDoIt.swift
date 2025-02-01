//
//  ViewController.swift
//  GoDoIt
//
//  Created by Basit Tri Anggoro on 22/01/25.
//

import UIKit

class GoDoIt: UITableViewController{
    var defaults = UserDefaults() //user default lari ke file plist, default bersifat persistent tapi cocoknya unntuk data yang kecil
    var activityModel = Activity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Panggil data dari userDefaults sebagai Array of Dictionary
        if let defaultData = defaults.array(forKey: "GoDoIt") as? [[String:Any]]{
            activityModel.activities = defaultData
        }
    }
    
    //MARK: - DATA SOURCES (Tempat Data Berasal) - NumberOfRowInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityModel.activities.count //jumlah activity di model
    }
    
    //MARK: - DATA SOURCES (Tempat Data Berasal) - CellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Deklarasi reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoDoItCell", for: indexPath)
        
        // Deklarasi text dan checkmark (khusus deklarasi aja, tanpa ubah nilai variabel
        let textLabelForCell = activityModel.activities[indexPath.row]["name"] as? String
        let checkmarkForCell = activityModel.activities[indexPath.row]["isDone"] as? Bool
        cell.textLabel?.text = textLabelForCell
        
        // Ternary Operator in Swift
        if let checkmark = checkmarkForCell{
            cell.accessoryType = checkmark ? .checkmark : .none
        }
        return cell
    }
    
    //MARK: - DATA DELEGATE (Tempat Data Diolah/Digunakan) - DidSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let act = activityModel.activities[indexPath.row]["isDone"] as? Bool {
            activityModel.activities[indexPath.row]["isDone"] = !act
        }
        tableView.reloadData() //reload TableView Cell (cellForRowAt)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - TOMBOL TAMBAH DATA (Alert)
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var extendedTextField = UITextField() //deklarasi textField utk menampung alert textField
        
        // Setting Alert
        let myAlert = UIAlertController(title: "Add Your Item", message: "Write Your Activity here!", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "Add", style: .default) { (myAction) in
            print("success!!")
            // Give value to activity model
            if let text = extendedTextField.text{
                self.activityModel.activities.append([
                    "name":text,
                    "isDone":false
                ])
                // Store data to user defaults
                self.defaults.set(self.activityModel.activities, forKey: "GoDoIt")
                self.tableView.reloadData()
            }
        }
        
        // Tambah Action Alert dan TextField
        myAlert.addAction(myAction)
        myAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write your item here!"
            extendedTextField = alertTextField
        }
        
        // Tampilkan/Jalankan Alert
        present(myAlert, animated: true, completion: nil)
    }
}


//        let myAlert = UIAlertController(title: "Your Productivity Increases", message: "Succesfully added an activity", preferredStyle: .alert)
//        let myAction = UIAlertAction(title: "Done", style: .default) { (myAction) in
//            print("success!!")
//        }
