//
//  QMStudent.swift
//  WangXiao
//
//  Created by penguin on 2021/4/14.
//

import Foundation

enum QMLinkState {
    // 连麦中
    case linking
    // 未连麦
    case notLink
    // 已连麦
    case didLink
}

/// 学生
class QMStudent: NSObject {
    /// 姓名
    var nickName:String = ""
    /// 头像地址
    var avatarUrl:String = ""
    /// 腾讯id
    var userCode:String = ""
    /// QM id
    var userId:Int64 = 0
    /// 荣誉分
    var expValue:Int = 0
    /// 荣誉奖杯
    var expIcon:String = ""
    /// 虚拟币
    var studyCoin:Int = 0
    /// 拉流地址
    var pullAddress:String = ""
    /// 在线状态
    var isOnline:Bool = false
    /// 连麦状态
    var linkState:QMLinkState = .notLink
    /// 是否举手
    var isHandUp:Bool = false
    
    /// 麦克风状态
    var isOpenMike:Bool = false
    /// 摄像头状态
    var isOpenCamera:Bool = false
    /// 上课提醒次数
    var alertCount:Int = 0
    
    /// 签到时间（秒）
    var signSecond:Int?
    
    init(nickName:String,
         avatarUrl:String,
         userCode:String,
         userId:Int64,
         expValue:Int,
         expIcon:String,
         studyCoin:Int) {
        self.nickName = nickName
        self.avatarUrl = avatarUrl
        self.userCode = userCode
        self.userId = userId
        self.expValue = expValue
        self.studyCoin = studyCoin
        let streamName = "camera_" + userCode
        self.pullAddress = "http://live.jledu.com/live/\(streamName).flv"
        self.expIcon = expIcon
    }
    
    func reloadData() {
        // 在线状态
        isOnline = false
        // 连麦状态
        linkState = .notLink
        // 是否举手
        isHandUp = false
        // 上课提醒次数
        alertCount = 0
        expIcon = ""
    }
}
