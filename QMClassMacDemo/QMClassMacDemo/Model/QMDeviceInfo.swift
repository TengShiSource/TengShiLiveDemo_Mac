//
//  QMDeviceInfo.swift
//  WangXiao
//
//  Created by penguin on 2021/4/26.
//

import Foundation

/// 当前设备信息
class QMDeviceInfo {
    /// 麦克风状态
    var isOpenMike:Bool = false
    /// 摄像头状态
    var isOpenCamera:Bool = false
    /// 前置摄像头还是后置摄像头
    var frontCamera:Bool = true
    /// 是否开启了美颜
    var isOpenBeautify:Bool = false
    /// 是否开启了镜像
    var isMirroring:Bool = false
    
    
    func set(isOpenMike:Bool, isOpenCamera:Bool, frontCamera:Bool, isOpenBeautify:Bool) {
        self.isOpenMike = isOpenMike
        self.isOpenCamera = isOpenCamera
        self.frontCamera = frontCamera
        self.isOpenBeautify = isOpenBeautify
    }
}
