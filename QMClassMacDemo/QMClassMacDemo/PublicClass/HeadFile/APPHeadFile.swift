//
//  APPHeadFile.swift
//
//  Created by penguin on 2019/5/28.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import SnapKit

//MARK: Log
func AppPrint<T>(_ message:T){
    #if DEBUG
    print(message)
    #endif
}

/// APP_KEY
let APP_KEY:String = "RMGF2JD1UY"
/// APP_SECRET
let APP_SECRET:String = "8OCFTPB1F7"

//MARK: 通知名称
///网络状态通知
let NOTIFICATION_NETWORK_STATUS:String = "networkStatus"

/// 腾讯云被踢下线
let NOTIFICATION_ON_TIC_FORCE_OFFLINE = "onTICForceOffline"
/// 开启美颜通知
let NOTIFICATION_OPEN_BEAUTIFY = "openBeautify"

//MARK: 项目通用信息

// APP版本号(例如 ： 1.2.3)
// 主版本号（1）：当功能模块有较大的变动，比如增加多个模块或者整体架构发生变化。此版本号由项目决定是否修改。
// 子版本号（2）：当功能有一定的增加或变化，比如增加了对权限控制、增加自定义视图等功能。此版本号由项目决定是否修改。
// 阶段版本号（3）：一般是Bug修复或是一些小的变动，要经常发布修订版，时间间隔不限，修复一个严重的bug即可发布一个修订版。此版本号由项目经理决定是否修改。

let APP_VERSION:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

//CFBundleVersion(Bundle)
let APP_VERSION_BUNDLE:String = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

//应用注册scheme,在Info.plist定义URL types(每个程序定义的都可能不一样，只要保持一致就行了)
let SCHEME:String = "qmschool"

let iTunes_URL = "itms-apps://itunes.apple.com/app/id1557806757"

//MARK: 属性列表路径

//MARK: 短信验证码长度
let SMS_CODE_LENGHT: Int = 4

//MARK: ViewModel中回调（闭包）
/// 结果回调
typealias resultMethod = (_ isSuccess:Bool, _ data:[String:Any]?, _ message:String, _ error:Error?) -> Void

// 服务器地址（正式环境）
// let DEFAULT_URL:String = "https://api.jledu.com/api"

// 服务器地址（开发环境）
 let DEFAULT_URL:String = "http://125.32.43.126:9208/live"

// 服务器地址（测试环境）
// let DEFAULT_URL:String = "http://jledu.f3322.net:10000/api"

//MARK: APP接口
/// 01 获取登陆人信息(GET)
let INTERFACE_GET_USERINFO:String = DEFAULT_URL+"/user/getLoginUser"

/// 02 根据课节id取得课系(GET)
let INTERFACE_STUDENT_COURSE_GET_BY_COURSEID:String = DEFAULT_URL+"/student/course/getByCourseId"

//MARK: APP接口

/// 01 (GET) 根据手机号与验证号获取一个appId,经过Gateway从外部调用
let INTERFACE_getAppId:String = DEFAULT_URL+"/app/getAppId"

/// 02 (POST) 配置直播间公共选项,更新表并更新缓存
let INTERFACE_setGlobalOptions:String = DEFAULT_URL+"/app/setGlobalOptions"

/// 03 (GET) 获取验证码
let INTERFACE_getVerifyCode:String = DEFAULT_URL+"/sms/getVerifyCode"

/// 04 (POST) 创建课 不创建腾讯云直播间，老师或学生进入直播间的时候先判断是否存在，如果不存储在前端调用TX sdk创建直播间，直播间号与后台给的courseId相同
let INTERFACE_createCourse:String = DEFAULT_URL+"/lvbcourse/createCourse"

/// 05 (POST) 进入直播间时调用，注册用户到直播间写表和缓存
let INTERFACE_registUser:String = DEFAULT_URL+"/member/registUser"

/// 05 (POST) 获取APP信息（验证id key）
let INTERFACE_getAppInfo:String = DEFAULT_URL+"/app/getAppInfo"

// 上传文件接口
let INTERFACE_uploadFile:String = DEFAULT_URL+"/upload/file"

// 获取课堂状态
let INTERFACE_getCourseParam:String = DEFAULT_URL+"/lvbcourse/getCourseParam"

// 获取头像列表
let INTERFACE_getAvatarUrlList:String = DEFAULT_URL+"/member/getAvatarUrlList"

// 获取历史课程列表
let INTERFACE_getCourseVideoList:String = DEFAULT_URL+"/member/getCourseVideoList"

/// (POST) 老师进入直播间前将班级内的所有学员信息推送给该接口，写入缓存;用于在课堂内显示未在线的学生；
let INTERFACE_addStudents:String = DEFAULT_URL+"/member/addStudents"

//MARK: system
/// (system-群)学生上线，老师与学生收到通知后同步自己的在线学生列表
let action_studentJoin = "studentJoin"
/// (system-群)学生下线，老师与学生收到通知后同步自己的在线学生列表
let action_studentExit = "studentExit"
/// (system-群)老师发起下课    退出直播间
let action_classOver = "classOver"
/// (system-群) 老师发起提问 1单选 2多选  3判断  4数字    code为题目编号
let action_question = "question"
/// (system-群) 老师关闭答题
let action_questionClose = "questionClose"
/// (system-群) 老师结束答题
let action_questionFinish = "questionFinish"
/// (system-群)老师发起抢答
let action_rushQuestion = "rushQuestion"
/// (system-群)抢答完成
let action_rushQuestionFinish = "rushQuestionFinish"
/// (system-群)抢答答题完成
let action_rushQuestionAnswerFinish = "rushQuestionAnswerFinish"
/// (system-群)老师向班里发红包
let action_redEnvelopeGroup = "redEnvelopeGroup"
/// (system-学生)老师某人发红包
let action_redEnvelope = "redEnvelope"
/// (system-学生)老师发送荣誉分
let action_sendExpValue = "sendExpValue"
/// (system-老师)学生发起问题
let action_pazzle = "pazzle"
/// (system-学生)下课延时
let action_delayCourse = "delayCourse"
/// (system-老师)课件转码进度
let action_coursewareCallback = "coursewareCallback"

//MARK: 老师
/// (老师-群)老师放大某个摄像头
let action_cameraFull = "cameraFull"
/// (老师-群)摄像头还原
let action_cameraBack = "cameraBack"
/// (老师-群)老师发起群体禁麦
let action_micDisable = "micDisable"
/// (老师-群)老师发起群体解除禁麦
let action_micEnableRequest = "micEnable"
/// (老师-群)老师发起让所有学生挂麦
let action_micAllClose = "micAllClose"
/// (老师-群)老师发起定时器
let action_timer = "timer"
/// (老师-群)老师取消定时器
let action_killTimer = "killTimer"
/// (老师-群)教师登陆时向学生群发通知（群）
let action_teacherJoin = "teacherJoin"
/// (老师-群)老师开启自己的摄像头
let action_teacherVideoOpen = "teacherVideoOpen"
/// (老师-群)老师关闭自己的摄像头
let action_teacherVideoClose = "teacherVideoClose"
/// (学生-老师) 学生处理老师的连麦请求  老师响应学生的连麦请求
let action_micOpenRequestResult = "micOpenRequestResult"
/// (老师-学生)同步教师状态
let action_synStatus = "synStatus"
/// (老师-学生)老师发起让学生连麦
let action_micOpen = "micOpen"
/// (老师-学生)老师发起让学生挂麦
let action_micClose = "micClose"
/// (老师-学生)老师发起禁言
let action_talkDisable = "talkDisable"
/// (老师-学生)老师解除禁言
let action_talkEnable = "talkEnable"
/// (老师-学生)老师发起点名
let action_rollCall = "rollCall"
/// (老师-学生)老师开启学生画笔
let action_brushEnable = "brushEnable"
/// (老师-学生)老师关闭学生画笔
let action_brushDisable = "brushDisable"
/// (老师-学生)老师发起让踢除某个学生
let action_kickOut = "kickOut"
/// (老师-群)老师通知某个学生连麦关麦
let action_micStuNotify = "micStuNotify"


//MARK: 学生
/// (学生-老师)老师发起群体解除禁麦
let action_micOpenRequest = "micOpenRequest"
/// (学生-老师)学生点名签到
let action_rollCallResponse = "rollCallResponse"
/// (学生-老师)学生发起举手
let action_handsUp = "handsUp"
/// (学生-老师)学生发起取消举手
let action_handsDown = "handsDown"
/// (学生-老师)学生发起做题
let action_commitQuestion = "commitQuestion"
/// (学生-群)学生在直播间中关闭摄像头
let action_studentVideoClose = "studentVideoClose"
/// (学生-群)学生在直播间中开启摄像头
let action_studentVideoOpen = "studentVideoOpen"
/// (学生-群)学生在直播间外开启直播推流
let action_studentVideoPush = "studentVideoPush"
//MARK: 多端
/// (多-群)聊天消息,双向
let action_msg = "msg"

//MARK: APP接口
/// (GET) 在直播间中取得用户信息，需要在header中带token
let QM_INTERFACE_getLoginInfo:String = DEFAULT_URL+"/member/getLoginInfo"

/// (POST) 老师进入直播间前将班级内的所有学员信息推送给该接口，写入缓存;用于在课堂内显示未在线的学生；
let QM_INTERFACE_addStudents:String = DEFAULT_URL+"/member/addStudents"

/// (GET) 获取所有学员列表（在直播间中使用，用于在课堂内显示未在线的学生；）
let QM_INTERFACE_getStudents:String = DEFAULT_URL+"/member/getStudents"

/// (GET) 取得在线学生列表
let QM_INTERFACE_getOnlineStudents:String = DEFAULT_URL+"/student/getOnlineStudents"

/// (GET) 成为当前授课老师（接管教室）
let QM_INTERFACE_becomeTeacher:String = DEFAULT_URL+"/member/becomeTeacher"

/// (GET) 获取课堂状态信息
//1、创建直播间的信息
//2、腾讯云房间号、APPID
//3、当前授课老师
let QM_INTERFACE_getCourseInfo:String = DEFAULT_URL+"/lvbcourse/getCourseInfo"

// (老师开启白板推流)
let QM_INTERFACE_startPushBoardStream:String = DEFAULT_URL+"/lvbcourse/startPushBoardStream"

// 下课。统计、停止录制、停止推流、发下课IM
let QM_INTERFACE_classOver:String = DEFAULT_URL+"/lvbcourse/classOver"

// 学生提问接口
let QM_INTERFACE_pazzle:String = DEFAULT_URL+"/pazzle/pazzle"

// 获取学生提问列表
let QM_INTERFACE_pazzleList:String = DEFAULT_URL+"/pazzle/pazzleList"

// 老师标记学员提问被解决
let QM_INTERFACE_resolvePazzle:String = DEFAULT_URL+"/pazzle/resolvePazzle"

// 上传文件接口
let QM_INTERFACE_uploadFile:String = DEFAULT_URL+"/upload/file"

// 上传点名信息
let QM_INTERFACE_rollcallRecord:String = DEFAULT_URL+"/lvbcourse/rollcallRecord"

// 答题统计
let QM_INTERFACE_studentAnswerStat:String = DEFAULT_URL+"/question/studentAnswerStat/"

// 答题明细
let QM_INTERFACE_studentAnswerList:String = DEFAULT_URL+"/question/studentAnswerList/"

// 创建答题
let QM_INTERFACE_question:String = DEFAULT_URL+"/question/question"

// 老师结束答题
let QM_INTERFACE_questionFinish:String = DEFAULT_URL+"/question/questionFinish/"
    
// 老师关闭答题
let QM_INTERFACE_questionClose:String = DEFAULT_URL+"/question/questionClose/"

// 学生答题
let QM_INTERFACE_answer:String = DEFAULT_URL+"/question/answer"

// 学生抢答
let QM_INTERFACE_rushQuestion:String = DEFAULT_URL+"/question/rushQuestion"

// 老师发红包接口
let QM_INTERFACE_envelopRedPack:String = DEFAULT_URL+"/member/envelopRedPack"
 
// 学生抢红包接口
let QM_INTERFACE_rushRedPack:String = DEFAULT_URL+"/member/rushRedPack"

// 延长下课时间
let QM_INTERFACE_delayCourseEndTime:String = DEFAULT_URL+"/lvbcourse/delayCourseEndTime/"

// 学生红包列表接口
let QM_INTERFACE_queryRedPackRecord:String = DEFAULT_URL+"/member/queryRedPackRecord"

// 开始录制课程
let QM_INTERFACE_startRecord:String = DEFAULT_URL+"/lvbcourse/startRecord"

// 结束录制课程
let QM_INTERFACE_stopRecord:String = DEFAULT_URL+"/lvbcourse/stopRecord"

// 上课提醒
let QM_INTERFACE_classReminder:String = DEFAULT_URL+"/member/classReminder/"


// 获取上传课件id
let QM_INTERFACE_getUploadCoursewareTaskId:String = DEFAULT_URL+"/member/getUploadCoursewareTaskId/"

// 上传课件
let QM_INTERFACE_uploadCourseware:String = DEFAULT_URL+"/member/uploadCourseware/"

// 取消上传课件 cancelUploadCourseware
let QM_INTERFACE_cancelUploadCourseware:String = DEFAULT_URL+"/member/cancelUploadCourseware/"

/// 老师分页获取直播间课件列表
let QM_INTERFACE_getCoursewarePage:String = DEFAULT_URL+"/member/getCoursewarePage"

/// 课件类型列表
let QM_INTERFACE_getCoursewareTypes:String = DEFAULT_URL+"/member/getCoursewareTypes"

