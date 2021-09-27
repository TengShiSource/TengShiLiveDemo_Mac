//
//  QMQuestion.swift
//  WangXiao
//
//  Created by penguin on 2021/5/18.
//

import Foundation

/// 题
class QMQuestion: NSObject {
    /// 该题的荣誉分
    var expValue:Int = 0
    /// 答题时长限制 秒
    var timeLimit:Int = 0
    /// 问题答案 用questionOptions中的值
    var questionAnswer:String = ""
    /// 问题选项 大写字母 ABCD ，问题类型为判断时类型时 A 正确 B错误
    var questionOptions:String = ""
    /// 问题类型 1 单选, 2 多选, 3 判断 4,数字
    var questionType:Int = 0
    /// 0 == 答题  1 == 抢答
    var questionMode:Int = 0
    /// 题目id
    var questionId:Int = 0
    
    /// 遍历构造器
    /// - Parameters:
    ///   - expValue: 该题的荣誉分
    ///   - timeLimit: 答题时长限制 秒
    ///   - questionAnswer: 问题答案 用questionOptions中的值
    ///   - questionOptions: 问题选项 大写字母 ABCD ，问题类型为判断时类型时 A 正确 B错误
    ///   - questionType: 问题类型 1 单选, 2 多选, 3 判断 4,数字
    ///   - questionMode: 0 == 答题  1 == 抢答
    ///   - questionId: 题目id
    func setValues(expValue:Int,
                   timeLimit:Int,
                   questionAnswer:String,
                   questionOptions:String,
                   questionType:Int,
                   questionMode:Int,
                   questionId:Int) {
        self.expValue = expValue
        self.timeLimit = timeLimit
        self.questionAnswer = questionAnswer
        self.questionOptions = questionOptions
        self.questionType = questionType
        self.questionMode = questionMode
        self.questionId = questionId
    }
}
