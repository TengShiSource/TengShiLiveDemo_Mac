//
//  QMRoomInfo.swift
//  WangXiao
//
//  Created by penguin on 2021/4/6.
//

import Foundation

/// 登录房间信息
class QMRoomInfo {
    /// token
    var token:String = ""
    /// userid
    var userid:Int64 = 0
    /// 腾讯id
    var userCode:String = ""
    /// 腾讯usersig
    var userSig:String = ""
    /// 是否是老师
    var isTeacher:Bool = false
    /// 课堂id（和classid一致，创建课堂时候填这个）
    var courseId:UInt64 = 0
    /// 用户名
    var nickName:String = ""
    /// 头像
    var avatar:String = ""
    /// 角色("t"==老师 "s"==学生)
    var userRole:String = ""
    /// SDK id
    var TXsdkAppid:Int32 = 0
    /// appid
    var appId:Int = 0
    /// 课堂名称
    var courseName:String = ""
    /// 开始时间
    var startTime:TimeInterval = 0
    /// 结束时间
    var endTime:TimeInterval = 0
    /// 荣誉分
    var expValue:Int = 0
    ///
    var expIcon:String = ""
    /// 虚拟币
    var studyCoin:Int = 0
    
    ///
    
    /// 老师的usercode（腾讯id）
    var tUserCode:String = ""
    var tAvatarUrl:String = ""
    var tNickName:String = ""
    var tUserId:String = ""
    
    //MARK: options
    ///1自动（默认） 2手动 3不录
    var recMethod:Int = 0
    /// 是否开启上课提醒
    var openClassReminder:Bool = false
    
    /// 设置登录信息
    func setLoginInfo(dic:[String:Any]) {
        self.studyCoin = dic["studyCoin"] as? Int ?? 0
        self.expValue = dic["expValue"] as? Int ?? 0
        self.userid = dic["userId"] as? Int64 ?? 0
        self.userCode = dic["userCode"] as? String ?? ""
        self.userSig = dic["userSig"] as? String ?? ""
        self.courseId = UInt64(dic["courseId"] as? Int64 ?? 0)
        self.userRole = dic["userRole"] as? String ?? ""
        self.isTeacher = self.userRole == "t" ? true : false
        self.nickName = dic["nickName"] as? String ?? ""
        self.avatar = dic["avatarUrl"] as? String ?? ""
        self.expIcon = dic["expIcon"] as? String ?? ""
    }
    
    /// 设置课堂信息
    func setCourseInfo(dic:[String:Any]) {
        self.TXsdkAppid = dic["txAppId"] as? Int32 ?? 0
        if let teacher = dic["teacher"] as? [String:Any] {
            self.tUserCode = teacher["userCode"] as? String ?? ""
            self.tAvatarUrl = teacher["avatarUrl"] as? String ?? ""
            self.tUserId = teacher["userId"] as? String ?? ""
            self.tNickName = teacher["nickName"] as? String ?? ""
        }
        if let course:[String:Any] = dic["course"] as? [String : Any] {
            self.appId = course["appId"] as? Int ?? 0
            self.courseName = course["courseName"] as? String ?? ""
            print(course["startTime"] as Any)
            
            
            if let startTime:String = (course["startTime"] as? String ?? "").stringToDate(formatString: "yyyy-MM-dd HH:mm:ss")?.timestampStringS() {
                self.startTime = Double(startTime) ?? 0
            }
            if let endTime:String = (course["endTime"] as? String ?? "").stringToDate(formatString: "yyyy-MM-dd HH:mm:ss")?.timestampStringS() {
                self.endTime = Double(endTime) ?? 0
            }
        }
        
        if let options:[String:Any] = dic["options"] as? [String:Any] {
            self.recMethod = options["recMethod"] as? Int ?? 0
            let openClassReminder = options["openClassReminder"] as? String ?? "n"
            if openClassReminder == "y" {
                self.openClassReminder = true
            }
            else {
                self.openClassReminder = false
            }
        }
    }
    
    func clear() {
        token = ""
        userid = 0
        userCode = ""
        userSig = ""
        isTeacher = false
        courseId = 0
        nickName = ""
        avatar = ""
        userRole = ""
        TXsdkAppid = 0
        appId = 0
        courseName = ""
        startTime = 0
        endTime = 0
        expValue = 0
        studyCoin = 0
        tUserCode = ""
        tAvatarUrl = ""
        tNickName = ""
        tUserId = ""
        recMethod = 0
        openClassReminder = false
    }
}
