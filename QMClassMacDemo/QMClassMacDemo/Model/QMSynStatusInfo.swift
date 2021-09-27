//
//  QMSynStatusInfo.swift
//  WangXiao
//
//  Created by penguin on 2021/5/26.
//

import Foundation

/// 同步状态
class QMSynStatusInfo: NSObject {
    /// 是否在禁言状态 1是0否
    var talkDisable:Int = 0
    /// 是否在禁麦状态(强制全体静音) 1是0否
    var micDisable:Int = 0
    /// 是否在点名状态 0代表不在点名状态 倒计时时间（秒）
    var rollCall:Int = 0
    /// 全屏视频的用户 code
    var cameraFull:String = ""
    ///正在台上的同学 code
    var micMembers:[String] = []
    /// 老师摄像头开关(老师端通过QMManager.shared.deviceInfo.isOpenCamera 记录)(学生端存储)
    var teacherCameraStatus:Int = 1
    /// 提问
    var questionStatus:[String:Any]?
    /// 计时器 0 代表没有  大于0 代表计时中
    var timer:Int = 0
    
    init(dictionory:[String:Any]) {

        if let status:[String:Any] = dictionory["status"] as? [String:Any] {
            // 是否在禁言状态 1是0否
            talkDisable = status["talkDisable"] as? Int ?? 0
            // 是否在禁麦状态(强制全体静音) 1是0否
            micDisable =  status["micDisable"] as? Int ?? 0
            // 老师摄像头开关(老师端通过QMManager.shared.deviceInfo.isOpenCamera 记录)(学生端存储)
            teacherCameraStatus = status["teacherCameraStatus"] as? Int ?? 1
            // 提问
            questionStatus = status["questionStatus"] as? [String:Any]
            //正在台上的同学 code
            micMembers = status["micMembers"] as? [String] ?? []
            // 是否在点名状态 0代表不在点名状态 倒计时时间（秒）
            rollCall = status["rollCall"] as? Int ?? 0
            // 全屏视频的用户 code
            cameraFull = status["cameraFull"] as? String ?? ""
            // 倒计时
            timer = status["timer"] as? Int ?? 0
        }
    }
}
