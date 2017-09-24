//
//  QuizViewController.swift
//  QuizSwift
//
//  Created by Keita Suzuki on 2017/08/17.
//  Copyright © 2017年 鈴木慶汰. All rights reserved.
//

import UIKit
import RealmSwift

class QuizViewController: UIViewController {
    
    var dataArray :[[String]] = []
    var dataArrayResult :Results<QuizData>!
    
    var qfunc = Questions()
    @IBOutlet weak var QuestionNoLabel: UILabel!
    @IBOutlet weak var lifegageLabel: UILabel!
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var QuizTextView: UITextView!
    @IBOutlet weak var AButton: UIButton!
    @IBOutlet weak var BButton: UIButton!
    @IBOutlet weak var CButton: UIButton!
    @IBOutlet weak var DButton: UIButton!
    
    @IBOutlet weak var LifeGage: UIView!
    @IBOutlet weak var TimeGage: UIView!
    
    var currentQuestion:Int = 0
    var life:Int = 5
    var anss:[Int] = []
    var answer:Int = 0
    
    var timerLabeled = 10.0
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(dataArray)   //FOR DEBUG USE ONLY
        
        qfunc.shuffle_Questions(size: dataArrayResult.count)
        
        QuizTextView.text = dataArrayResult[qfunc.AnswerArray_Rand[currentQuestion]].Quiz
        QuestionNoLabel.text = "No. " + String(currentQuestion + 1)
        lifegageLabel.text = "Life: " + String(life)
 
        LifeGageAdjuster()
 
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timeupdate), userInfo: nil, repeats: true)
        TimeLabel.text = String(timerLabeled)
 
        answer = qfunc.AnswerArray_Rand[currentQuestion]
        anss = qfunc.shuffle_answers(current_answer: qfunc.AnswerArray_Rand[currentQuestion])
        AButton.setTitle(dataArrayResult[anss[0]].Answer, for: UIControlState.normal)
        BButton.setTitle(dataArrayResult[anss[1]].Answer, for: UIControlState.normal)
        CButton.setTitle(dataArrayResult[anss[2]].Answer, for: UIControlState.normal)
        DButton.setTitle(dataArrayResult[anss[3]].Answer, for: UIControlState.normal)
 
        timer.fire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AbuttonAction(_ sender: Any) {
        whenPushed(Chosen: 0)
    }
    
    @IBAction func BbuttonAction(_ sender: Any) {
        whenPushed(Chosen: 1)
    }
    
    @IBAction func CbuttonAction(_ sender: Any) {
        whenPushed(Chosen: 2)
    }
    
    @IBAction func DbuttonAction(_ sender: Any) {
        whenPushed(Chosen: 3)
    }
    
    func timeupdate(){
        timerLabeled -= 0.1
        TimeGage.frame.size.width = CGFloat(20.0 * timerLabeled)
        TimeLabel.text = String(format:"%.1f",timerLabeled)
        
        if timerLabeled >= 5 {
            TimeGage.backgroundColor = UIColor.blue
        } else if timerLabeled >= 2 {
            TimeGage.backgroundColor = UIColor.yellow
        } else if timerLabeled > 0 {
            TimeGage.backgroundColor = UIColor.red
        }else if timerLabeled == 0 {
            life -= 1
            if life > 0{
                LifeGageAdjuster()
                let alert:UIAlertController = UIAlertController(title:"TIME UP", message: "lose one life", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction:UIAlertAction = UIAlertAction(title: "OK",
                                                               style: UIAlertActionStyle.cancel,
                                                               handler:{
                                                                (action:UIAlertAction!) -> Void in
                                                                print("OK")
                })
                alert.addAction(cancelAction)
                lifegageLabel.text = "Life: " + String(life)
                present(alert, animated: true, completion: nil)
                timerLabeled = 10
                TimeGage.backgroundColor = UIColor.blue
            } else {
                if let gameoverViewController = storyboard?.instantiateViewController(withIdentifier: "gameover") {
                    self.present(gameoverViewController, animated:true, completion: nil)
                }
            }

        }
    }
    
    func whenPushed(Chosen:Int){
        if anss[Chosen] == answer {
            timerLabeled = 10
            currentQuestion += 1
            if currentQuestion == dataArray.count {
                if let finalViewController = storyboard?.instantiateViewController(withIdentifier: "result") {
                    self.present(finalViewController,animated:true,completion: nil)
                }
            } else {
                QuizTextView.text = dataArrayResult[qfunc.AnswerArray_Rand[currentQuestion]].Quiz
                QuestionNoLabel.text = "No. " + String(currentQuestion + 1)
                TimeLabel.text = String(timerLabeled)
                answer = qfunc.AnswerArray_Rand[currentQuestion]
                anss = qfunc.shuffle_answers(current_answer: qfunc.AnswerArray_Rand[currentQuestion])
                AButton.setTitle(dataArrayResult[anss[0]].Answer, for: UIControlState.normal)
                BButton.setTitle(dataArrayResult[anss[1]].Answer, for: UIControlState.normal)
                CButton.setTitle(dataArrayResult[anss[2]].Answer, for: UIControlState.normal)
                DButton.setTitle(dataArrayResult[anss[3]].Answer, for: UIControlState.normal)
            }
        }else{
            life -= 1
            if life > 0{
                LifeGageAdjuster()
                let alert:UIAlertController = UIAlertController(title:"WRONG ANSWER", message: "Try again", preferredStyle: UIAlertControllerStyle.alert)
                let cancelAction:UIAlertAction = UIAlertAction(title: "OK",
                                                               style: UIAlertActionStyle.cancel,
                                                               handler:{
                                                                (action:UIAlertAction!) -> Void in
                                                                print("OK")
                })
                alert.addAction(cancelAction)
                lifegageLabel.text = "Life: " + String(life)
                present(alert, animated: true, completion: nil)
            } else {
                if let gameoverViewController = storyboard?.instantiateViewController(withIdentifier: "gameover") {
                    self.present(gameoverViewController, animated:true, completion: nil)
                }
            }
        }

    }
    
    func LifeGageAdjuster(){
        if life >= 3 {
            LifeGage.backgroundColor = UIColor.green
        } else if life == 2{
            LifeGage.backgroundColor = UIColor.yellow
        } else {
            LifeGage.backgroundColor = UIColor.red
        }
        
        LifeGage.frame.size.width = CGFloat(30 * life)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
