//
//  ViewController.swift
//  QuizSwift
//
//  Created by Keita Suzuki on 2017/08/17.
//  Copyright © 2017年 鈴木慶汰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var ListNo: Int = 0
    let DS = DataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
         //DS.preset()    //FOR PRESET DATA ONLY
        //let test = DS.getQuiz(ID: 0)    //DEBUG USE ONLY
        //print(test)   //DEBUG USE ONLY
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toQuiz"){
            let viewController = segue.destination as! QuizViewController
            let quizes = DS.getQuiz(ID: ListNo)
            viewController.dataArrayResult = quizes
        }
        
        if(segue.identifier == "toList"){
            let viewController = segue.destination as! ListTableViewController
            
            let lists = DS.getFullList()
            viewController.vocabListResult = lists
        }
        
        /*if(segue.identifier == "toListNeo"){
            let viewController = segue.destination as! ListNeoTableViewController
            
            let lists = DS.getFullList()
            viewController.vocabListResult = lists
        }*/
    }
    
    
    //come back from table view
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }

}

