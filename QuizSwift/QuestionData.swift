//
//  QuestionData.swift
//  QuizSwift
//
//  Created by Keita Suzuki on 2017/08/17.
//  Copyright © 2017年 鈴木慶汰. All rights reserved.
//

import Foundation

class Questions{
    
    var AnswerArray_Rand:[Int] = []
    
    func shuffle_Questions(size: Int){
        var AnswerArray_Ascend: [Int] = []
        for i in 0..<size{
            AnswerArray_Ascend.append(i)
        }
        
        while AnswerArray_Ascend.count != 0{
            let randomizer = Int(arc4random_uniform(UInt32(AnswerArray_Ascend.count)))
            AnswerArray_Rand.append(AnswerArray_Ascend[randomizer])
            AnswerArray_Ascend.remove(at: randomizer)
        }
        
        //print(AnswerArray_Rand)  //FOR DEBUG USE ONLY
    }
    
    func shuffle_answers(current_answer:Int) -> [Int]{
        var AnswerArray_Ascend: [Int] = []
        var Answerkeys:[Int] = []
        var Answerkeys_Shuffled:[Int] = []
        
        for i in 0..<AnswerArray_Rand.count{
            AnswerArray_Ascend.append(i)
        }
        AnswerArray_Ascend.remove(at: current_answer)
        Answerkeys.append(current_answer)
        
        for _ in 0..<3{
            let randomizer = Int(arc4random_uniform(UInt32(AnswerArray_Ascend.count)))
            Answerkeys.append(AnswerArray_Ascend[randomizer])
            AnswerArray_Ascend.remove(at: randomizer)
        }
        
        for _ in 0...3{
            let randomizer = Int(arc4random_uniform(UInt32(Answerkeys.count)))
            Answerkeys_Shuffled.append(Answerkeys[randomizer])
            Answerkeys.remove(at: randomizer)
        }
        
        return Answerkeys_Shuffled
    }
}
