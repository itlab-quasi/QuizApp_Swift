//
//  DataSource.swift
//  QuizSwift
//
//  Created by Keita Suzuki on 2017/08/19.
//  Copyright © 2017年 鈴木慶汰. All rights reserved.
//

import Foundation
import RealmSwift

class DataSource {
    let realm = try! Realm()
    
    func makeQuiz(No: Int, quiz_content: String, answer_content: String){
        let quiz = QuizData()
        quiz.ListNo = No
        quiz.Quiz  = quiz_content
        quiz.Answer = answer_content
        
        try! realm.write() {
            realm.add(quiz)
        }
    }
    
    func makeList(ID:Int, Name:String){
        let list = ListData()
        list.ListNo = ID
        list.ListName = Name
        
        try! realm.write() {
            realm.add(list)
        }

    }
    
    func getQuiz(ID: Int) -> Results<QuizData>{
        let quizes = realm.objects(QuizData.self).filter("ListNo = " + String(ID))
        
        return quizes
    }
    
    func getFullList() -> Results<ListData>{
        let lists = realm.objects(ListData.self)
        
        return lists
    }

    func getList(ID: Int) -> Results<QuizData>{
        let lists = realm.objects(QuizData.self).filter("ListNo = " + String(ID))
        
        return lists
    }
    
    func checkListNameValid(List_Name: String) -> Bool{
        let result = realm.objects(ListData.self).index(matching: "ListName = %@", List_Name)
        if result == nil {
            return true
        } else {
            return false
        }
    }
    
    func getListTitle(ID: Int) -> String{
        let list = realm.objects(ListData.self).filter("ListNo = " + String(ID))
        
        let listTitle = list[0].ListName
        
        return listTitle
    }
    
    //For preset issue only
    func preset(){
        var dataArray:[[String]] = [];
        if let csvPath = Bundle.main.path(forResource: "tempquestions", ofType: "csv") {
            do {
                let csvStr = try String(contentsOfFile:csvPath, encoding:String.Encoding.utf8)
                let csvArr = csvStr.components(separatedBy: .newlines)
                
                for csvFile in csvArr {
                    let csvSplit = csvFile.components(separatedBy: ",")
                    dataArray.append(csvSplit)
                }
                dataArray.removeLast()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            self.makeList(ID: 0, Name: "List 1")
            
            for i in 0..<dataArray.count{
                self.makeQuiz(No: 0,quiz_content: dataArray[i][0], answer_content: dataArray[i][1])
            }
        
        }
  
    }
    
}

class QuizData: Object{
    dynamic var ListNo:Int = 0
    dynamic var Quiz:String = ""
    dynamic var Answer:String = ""
}

class ListData: Object{
    dynamic var ListNo:Int = 0
    dynamic var ListName:String = ""
}

