//
//  APPSingleton.swift
//
//  Created by penguin on 2019/5/30.
//  Copyright © 2019 Penguin. All rights reserved.
//

import Foundation
import KeychainAccess
import WebKit
import Alamofire

//MARK: Keychain
/// 名称
let SERVICE_NAME = "com.QiMing.qmschool"
/// 设备唯一标识
let ONLY_IDENTIFIER = "ONLY_IDENTIFIER"

/// 登录方式
enum AppLoginMethod {
    /// 未知（不会出现）
    case unknown
    /// 手机短信验证码方式
    case phoneSMS
    /// 微信授权
    case weChat
}

//MARK: UserDefaults KEY

/// (推送设备号)deviceToken
let KEY_DEVICE_TOKEN = "deviceToken"

let KEY_QMAPPID = "QMAPPID"
let KEY_QMAPPSECRET = "QMAPPSECRET"
let KEY_QMSTART_TIME = "StartTime"
///
let KEY_LOGIN_ROLE_TYPE = "loginRoleType"
///
let KEY_ORG_ID = "orgId"
///
let KEY_TOKEN = "token"
///
let KEY_USER_CODE = "userCode"
///
let KEY_USER_ID = "userId"
///
let KEY_USER_COURSE_ID = "CourseId"
let KEY_USER_COURSE_NAME = "COURSE_NAME"
///
let KEY_USER_SIG = "userSig"
/// 学生密码
let KEY_S_PASSWORD = "sPassword"
/// 老师密码
let KEY_T_PASSWORD = "tPassword"

/// unionId
private let KEY_UNIONID = "unionId"
/// 昵称 nickname
private let KEY_NICKNAME = "nickname"
/// 性别gender
private let KEY_GENDER = "gender"
/// 用户头像 userLogo
private let KEY_USERLOGO = "userLogo"
/// 用户头像 userLogo
private let KEY_AVATAR_IMAGE = "avatarImage"
/// 电话 mobile
private let KEY_MOBILE = "mobile"
/// isLogin
private let KEY_ISLOGIN = "isLogin"
/// isFirstLogin
private let KEY_FIRST_ISLOGIN = "isFirstLogin"



/// 单例模式
class APPSingleton:NSObject {
    
    //MARK: 单例
    /// 单例
    static let shared = APPSingleton()
    
    //MARK: 构造函数，如果在 init 之前增加private修饰符，可以要求调用者必须通过shared访问对象
    /// 构造函数，如果在 init 之前增加private修饰符，可以要求调用者必须通过shared访问对象
    private override init() {
        
    }

    //MARK:用户登录信息
    
    var loginRoleType:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_LOGIN_ROLE_TYPE){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_LOGIN_ROLE_TYPE)
            UserDefaults.standard.synchronize()
        }
    }
    /// "orgId": 0）
    var orgId:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_ORG_ID){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_ORG_ID)
            UserDefaults.standard.synchronize()
        }
    }
    /// "userCode": "string",）
    var userCode:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_USER_CODE){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_USER_CODE)
            UserDefaults.standard.synchronize()
        }
    }
    /// "userId": 0）
    var userId:Int {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_USER_ID){
                return value is Int ? (value as! Int) : 0
            }
            else{
                return 0
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_USER_ID)
            UserDefaults.standard.synchronize()
        }
    }
    /// "userSig": "string"）
    var userSig:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_USER_SIG){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_USER_SIG)
            UserDefaults.standard.synchronize()
        }
    }
    /// "wxUnionId": "string"）
    var unionId:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_UNIONID){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_UNIONID)
            UserDefaults.standard.synchronize()
        }
    }

    /// 性别("gender": 0,)
    var gender:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_GENDER){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_GENDER)
            UserDefaults.standard.synchronize()
        }
    }

    /// 用户头像("avatarUrl": "string",)
    var userLogo:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_USERLOGO){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
                // "https://img2.baidu.com/it/u=3355464299,584008140&fm=26&fmt=auto&gp=0.jpg"
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_USERLOGO)
            UserDefaults.standard.synchronize()
        }
    }
    /// 电话（"mobile": "string",）
    var mobile:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_MOBILE){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_MOBILE)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: 登录信息遍历设置方法
    func setLoginInfo(dictionory:[String:Any]) {
        self.loginRoleType = dictionory["loginRoleType"] as? String ?? ""
        self.orgId = String(dictionory["orgId"] as? Int ?? 0)
        self.userCode = dictionory["userCode"] as? String ?? ""
        self.userId = dictionory["userId"] as? Int ?? 0
        self.userSig = dictionory["userSig"] as? String ?? ""
        self.unionId = dictionory["wxUnionId"] as? String ?? ""
        self.nickname = dictionory["nickName"] as? String ?? ""
        self.gender = String(dictionory["gender"] as? Int ?? 0)
        self.userLogo = dictionory["avatarUrl"] as? String ?? ""
        self.mobile = dictionory["mobile"] as? String ?? ""
    }
    
    //MARK:APP相关信息
    /// 登录状态（是否在登录中）
    var isLogin:Bool {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_ISLOGIN){
                return value is Bool ? (value as! Bool) : false
            }
            else{
                return false
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_ISLOGIN)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 第一次登录标记（是否显示引导页）
    var isFirstLogin:Bool {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_FIRST_ISLOGIN){
                return value is Bool ? (value as! Bool) : true
            }
            else{
                return true
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_FIRST_ISLOGIN)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 登录方式
    var loginMethod:AppLoginMethod = AppLoginMethod.unknown
    
    /// 推送设备号(持久化)
    var deviceToken:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_DEVICE_TOKEN){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_DEVICE_TOKEN)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 启明appid
    var QMAPPID:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_QMAPPID){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_QMAPPID)
            UserDefaults.standard.synchronize()
        }
    }
    /// 启明appSecret
    var QMAPPSecret:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_QMAPPSECRET){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_QMAPPSECRET)
            UserDefaults.standard.synchronize()
        }
    }
    /// 课程id
    var QMCourseId:Int {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_USER_COURSE_ID){
                return value is Int ? (value as! Int) : 0
            }
            else{
                return 0
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_USER_COURSE_ID)
            UserDefaults.standard.synchronize()
        }
    }
    /// 课程名称 KEY_USER_COURSE_NAME
    var QMCourseName:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_USER_COURSE_NAME){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_USER_COURSE_NAME)
            UserDefaults.standard.synchronize()
        }
    }
    /// 课程开始时间
    var QMStartTime:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_QMSTART_TIME){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_QMSTART_TIME)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 老师密码
    var sPassword:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_S_PASSWORD){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_S_PASSWORD)
            UserDefaults.standard.synchronize()
        }
    }

    /// 学生密码
    var tPassword:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_T_PASSWORD){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_T_PASSWORD)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 启明 token
    var QMToken:String = ""
    
    /// 昵称（"nickName": "string"）
    var nickname:String {
        get{
            if let value = UserDefaults.standard.value(forKey: KEY_NICKNAME){
                return value is String ? (value as! String) : ""
            }
            else{
                return ""
            }
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: KEY_NICKNAME)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// 注销（清空用户登录信息及本地存储的信息）
    func logout() {
        //FIXME:清空登录信息及本地信息
        loginMethod = AppLoginMethod.unknown
        isLogin = false
        loginRoleType = ""
        orgId = ""
        //token = ""
        userCode = ""
        userId = 0
        userSig = ""
        unionId = ""
        nickname = ""
        gender = ""
        userLogo = ""
        mobile = ""
    }
    
    /// 清除全部缓存（后期优化单独拿出去）
    func clearBrowserCache() {
        let dateFrom:Date = Date.init(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: dateFrom) {
        }
    }
    
    /// 屏幕亮度
    /// - Parameter level: 0 - 1
    func setBrightnessLevel(level: Float) {
        var iterator: io_iterator_t = 0
        if IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IODisplayConnect"), &iterator) == kIOReturnSuccess {
            var service: io_object_t = 1
            while service != 0 {
                service = IOIteratorNext(iterator)
                IODisplaySetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString, level)
                IOObjectRelease(service)
            }
        }
    }
    
    
    //MARK: 2.0接口调用
    
    /// 验证APP信息
    /// - Parameters:
    ///   - completion: 回调
    func requestGetAppInfo(completion:@escaping resultMethod) {
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String : String] = [:]
        manager.GETRequest(URLString: INTERFACE_getAppInfo,
                            parameters: &parameters,
                            token: "") { (requestData) in
            AppPrint(JSONSerialization.JSONString(object: requestData))
            let code: Int? = requestData["code"] as? Int
            if StatusCode.succeed(code: code){
                if let data:[String:Any] = requestData["data"] as? [String:Any]{
                    completion(true, data, "", nil)
                }
                else {
                    completion(false, nil, "空数据", nil)
                }
            }
            else{
                completion(false, nil, requestData["msg"] as? String ?? "code:\(String(describing: code))", nil)
            }
        } failure: { (error) in
            completion(false, nil, "请求失败", error)
        }
        
    }
    
    
    /// (GET)获取验证码
    /// - Parameters:
    ///   - mobile: 电话
    ///   - vcType: 验证码类型
    ///   - completion: 回调（验证码）
    func requestGetVerifyCode(mobile:String,
                              vcType:String,
                              completion:@escaping resultMethod) {
        
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        parameters["mobile"] = mobile
        parameters["vcType"] = vcType
        
        manager.GETRequest(URLString: INTERFACE_getVerifyCode,
                           parameters: &parameters,
                           token: "",
                           success: {requestData in
                            AppPrint(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                completion(true, nil, "成功", nil)
                            }
                            else{
                                completion(false, nil, requestData["msg"] as? String ?? "code:\(String(describing: code))", nil)
                            }
                            
                           },
                           failure: { error in
                            AppPrint(error as Any)
                            completion(false, nil, "请求失败", error)
                           })
        
    }
    
    
    /// (GET)根据手机号与验证码获取一个appId
    /// - Parameters:
    ///   - mobile: 电话
    ///   - orgName: 机构名称
    ///   - checkCode: 验证码
    ///   - completion: 回调（appId）
    func requestGetAppId(mobile:String,
                         orgName:String,
                         verifyCode:String,
                         completion:@escaping resultMethod) {
        
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        parameters["mobile"] = mobile
        parameters["orgName"] = orgName
        parameters["verifyCode"] = verifyCode
        manager.GETRequest(URLString: INTERFACE_getAppId,
                           parameters: &parameters,
                           token: APPSingleton.shared.QMToken,
                           success: {requestData in
                            AppPrint(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                //
                                if let data:String = requestData["data"] as? String{
                                    APPSingleton.shared.QMAPPID = data
                                    completion(true, nil, "", nil)
                                }
                                else {
                                    completion(false, nil, "空数据", nil)
                                }
                            }
                            else{
                                completion(false, nil, requestData["msg"] as? String ?? "code:\(String(describing: code))", nil)
                            }
                           },
                           failure: { error in
                            completion(false, nil, "请求失败", error)
                           })
    }

    /// (POST)创建课，不创建腾讯云直播间，老师或学生进入直播间的时候先判断是否存在，如果不存储在前端调用TX sdk创建直播间，直播间号与后台给的courseId相同
    /// - Parameters:
    ///   - appId: 必填
    ///   - courseName: 可以不填，默认课节名为：课堂yyyyMMddHHmmss
    ///   - teacherPwd: 老师密码
    ///   - studentPwd: 学生密码 可以不填，如果有密码，则调用registUser时会验证密码
    ///   - startTime: 如果不填，等于当前系统时间
    ///   - endTime: 可以不填，预约课才有
    ///   - courseOptions: 课相关设置
    ///   - completion: 回调courseId
    func requestCreateCourse(appId:String,
                              courseName:String,
                              teacherPwd:String,
                              studentPwd:String,
                              startTime:String,
                              endTime:String,
                              courseOptions:[String:Any],
                              completion:@escaping resultMethod) {
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String : Any] = [:]
        parameters["appId"] = appId
        parameters["courseName"] = courseName
        parameters["teacherPwd"] = teacherPwd
        parameters["studentPwd"] = studentPwd
        parameters["startTime"] = startTime
        parameters["endTime"] = endTime
        parameters["courseOptions"] = courseOptions
        manager.POSTRequest(URLString: INTERFACE_createCourse,
                            parameters: &parameters,
                            token: "") { (requestData) in
            AppPrint(JSONSerialization.JSONString(object: requestData))
            let code: Int? = requestData["code"] as? Int
            if StatusCode.succeed(code: code){
                
                if let data:Int = requestData["data"] as? Int{
                    APPSingleton.shared.QMCourseId = data
                    APPSingleton.shared.sPassword = studentPwd
                    APPSingleton.shared.tPassword = teacherPwd
                    completion(true, nil, "", nil)
                }
                else {
                    completion(false, nil, "空数据", nil)
                }
            }
            else{
                completion(false, nil, requestData["msg"] as? String ?? "code:\(String(describing: code))", nil)
            }
        } failure: { (error) in
            completion(false, nil, "请求失败", error)
        }
    }
    
    /// (POST)注册用户
    /// - Parameters:
    ///   - userid: 用户id，可选项
    ///   - courseId: 房间号
    ///   - password: 密码
    ///   - nickName: 昵称
    ///   - role: 角色(teacher/student)
    ///   - avatarUrl: 头像url
    ///   - deviceToken: 推送deviceToken
    ///   - expValue: 已有荣誉分数
    ///   - completion: 回调（token）
    func requestRegistUser(userid:Int,
                           courseId:Int,
                           password:String,
                           nickName:String,
                           role:String,
                           avatarUrl:String,
                           deviceToken:String,
                           originExpValue:Int,
                           completion:@escaping resultMethod) {
        
        ///网络请求
        let manager = APPNetWorkingManager()
        
        var parameters:[String:Any] = [:]
        parameters["userId"] = userid
        parameters["courseId"] = courseId
        parameters["password"] = password
        parameters["nickName"] = nickName
        parameters["role"] = role
        parameters["avatarUrl"] = avatarUrl
        parameters["deviceToken"] = deviceToken
        parameters["originExpValue"] = originExpValue
        manager.POSTRequest(URLString: INTERFACE_registUser,
                            parameters: &parameters,
                            token: "") { (requestData) in
            AppPrint(JSONSerialization.JSONString(object: requestData))
            let code: Int? = requestData["code"] as? Int
            if StatusCode.succeed(code: code){
                if let token:String = requestData["data"] as? String {
                    APPSingleton.shared.QMToken = token
                    completion(true, nil, "", nil)
                }
                else {
                    completion(false, nil, "", nil)
                }
            }
            else{
                completion(false, nil, requestData["msg"] as? String ?? "code:\(String(describing: code))", nil)
            }
        } failure: { (error) in
            completion(false, nil, "请求失败", error)
        }
    }
    
    /// 获取课堂状态
    /// - Parameters:
    ///   - courseId: 课堂id
    ///   - completion: 回调
    func requestGetCourseParam(courseId:String,
                         completion:@escaping resultMethod) {
        
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:String] = [:]
        parameters["courseId"] = courseId

        manager.GETRequest(URLString: INTERFACE_getCourseParam,
                           parameters: &parameters,
                           token: APPSingleton.shared.QMToken,
                           success: {requestData in
                            AppPrint(JSONSerialization.JSONString(object: requestData))
                            let code: Int? = requestData["code"] as? Int
                            if StatusCode.succeed(code: code){
                                //
                                if let data:[String:Any] = requestData["data"] as? [String:Any]{
                                    completion(true, data, "", nil)
                                }
                                else {
                                    completion(false, nil, "空数据", nil)
                                }
                            }
                            else{
                                completion(false, nil, requestData["msg"] as? String ?? "code:\(String(describing: code))", nil)
                            }
                           },
                           failure: { error in
                            completion(false, nil, "请求失败", error)
                           })
    }
    
}
