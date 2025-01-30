//
//  ViewController.swift
//  GoDoIt
//
//  Created by Basit Tri Anggoro on 22/01/25.
//

import UIKit

class GoDoIt: UITableViewController{
    
    var hardCodedData = ["Go Read A Book", "Go Jogging", "Go Buy Groceries"]
    var defaults = UserDefaults() //user default lari ke file plist, default bersifat persistent tapi cocoknya unntuk data yang kecil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Panggil data dari userDefaults sebagai String
        if let defaultData = defaults.array(forKey: "GoDoIt") as? [String]{
            hardCodedData = defaultData
        }
    }
    
    //MARK: - DATA SOURCES (Tempat Data Berasal)
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hardCodedData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoDoItCell", for: indexPath)
        cell.textLabel?.text = hardCodedData[indexPath.row]
        return cell
    }
    
    //MARK: - DATA DELEGATE (Tempat Data Diolah/Digunakan)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - TOMBOL TAMBAH DATA (Alert)
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print("abc")
        var extendedTextField = UITextField() //deklarasi textField utk menampung textField alert
        
        //Setting Alert
        let myAlert = UIAlertController(title: "Add Your Item", message: "Write Your Activity here!", preferredStyle: .alert)
        let myAction = UIAlertAction(title: "Add", style: .default) { (myAction) in
            print("success!!")
            if let text = extendedTextField.text{
                self.hardCodedData.append(text)
                self.defaults.set(self.hardCodedData, forKey: "GoDoIt")
                self.tableView.reloadData()
            }
        }
        
        //Tambah Action Alert dan TextField
        myAlert.addAction(myAction)
        myAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Write your item here!"
            extendedTextField = alertTextField
        }
        
        //Tampilkan/Jalankan Alert
        present(myAlert, animated: true, completion: nil)
    }
}


//        let myAlert = UIAlertController(title: "Your Productivity Increases", message: "Succesfully added an activity", preferredStyle: .alert)
//        let myAction = UIAlertAction(title: "Done", style: .default) { (myAction) in
//            print("success!!")
//        }
