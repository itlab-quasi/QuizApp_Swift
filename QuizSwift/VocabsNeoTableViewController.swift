//
//  VocabsNeoTableViewController.swift
//  QuizSwift
//
//  Created by Keita Suzuki on 2017/08/19.
//  Copyright © 2017年 鈴木慶汰. All rights reserved.
//

import UIKit
import RealmSwift

class VocabsNeoTableViewController: UITableViewController,UITextFieldDelegate {
    var vocabListResult:Results<QuizData>!
    var listindex: Int = 0
    var newVocabName:String = ""
    var newMeaningName:String = ""
    let DS = DataSource()
    
    @IBOutlet var VocabTableView: UITableView!
    @IBOutlet weak var TitleNavigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBAction func addVocabButton(_ sender: Any) {
        let alert = UIAlertController(title:"Add New Vocab", message:"Type in new Vocab", preferredStyle: .alert)
        
        alert.addTextField{(textField) -> Void in
            textField.delegate = self
            textField.placeholder = "Vocab"
            
        }

        alert.addTextField{(textField) -> Void in
            textField.delegate = self
            textField.placeholder = "Meaning"
        }
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler:{(action) -> Void in
                let textFields:Array<UITextField>? =  alert.textFields as Array<UITextField>?
                if textFields != nil {
                    self.newVocabName = textFields![0].text!
                    self.newMeaningName = textFields![1].text!
                }
                self.addNewVocab()})
        )
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        )
        
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       //do nothing
    }

    func addNewVocab(){
        if(newVocabName != "" && newMeaningName != ""){
            DS.makeQuiz(No: listindex, quiz_content: newVocabName, answer_content: newMeaningName)
            vocabListResult = DS.getList(ID: listindex)
            VocabTableView.reloadData()
            /*if DS.checkListNameValid(List_Name: newListName) {
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
                
            }*/
        } else {
            let alert = UIAlertController(title:"Input Invalid", message:"Vocab/Meaning must be inputed", preferredStyle: .alert)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "vocabList", for: indexPath)
        
        cell.textLabel?.text = vocabListResult[indexPath.row].Quiz
        cell.detailTextLabel?.text = vocabListResult[indexPath.row].Answer
        
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
