//
//  ListNeoTableViewController.swift
//  QuizSwift
//
//  Created by Keita Suzuki on 2017/08/19.
//  Copyright © 2017年 鈴木慶汰. All rights reserved.
//

import UIKit
import RealmSwift

class ListNeoTableViewController: UITableViewController, UITextFieldDelegate {
    var vocabListResult:Results<ListData>!
    var chosenlist:Int = 0
    let DS = DataSource()
    var newListName:String = ""
    
    @IBOutlet var originalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lists = DS.getFullList()
        vocabListResult = lists
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBAction func addListButton(_ sender: Any) {
        let alert = UIAlertController(title:"Add New List", message:"Type in new List Name", preferredStyle: .alert)
        
        alert.addTextField{(textField) -> Void in
            textField.delegate = self
        }
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler:{(action) -> Void in
        self.addNewList()})
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        )
        
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        newListName = textField.text!
    }
    
    func addNewList(){
        if newListName != "" {
            if DS.checkListNameValid(List_Name: newListName) {
                DS.makeList(ID:DS.getFullList().count, Name: newListName)
                vocabListResult = DS.getFullList()
                originalTableView.reloadData()
            } else {
                let alert = UIAlertController(title:"List Name Invalid", message:"List name exists already", preferredStyle: .alert)
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: nil
                    )
                )
                present(alert, animated: true, completion: nil)

            }
        } else {
            let alert = UIAlertController(title:"List Name Invalid", message:"List name must be inputed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
                )
            )
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vocabListResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Listcell", for: indexPath)
        
        cell.textLabel?.text = vocabListResult[indexPath.row].ListName
        
        return cell
    }
    
    //Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        chosenlist = indexPath.row
        performSegue(withIdentifier: "todetail",sender: nil)
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todetail" {
            let viewController = segue.destination as! VocabsNeoTableViewController
            let lists = DS.getList(ID: chosenlist)
            viewController.listindex = chosenlist
            viewController.vocabListResult = lists
            viewController.TitleNavigation.title = DS.getListTitle(ID: chosenlist)
         }
    }
    
    
}
