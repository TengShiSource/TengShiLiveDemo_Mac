//
//  CreateClassroomViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

@objc protocol CreateClassroomViewControllerDelegate : NSObjectProtocol {
    ///
    @objc func createClassroomDidDone()
}

/// 创建课
class CreateClassroomViewController: BaseViewController {
    
    weak var delegate:CreateClassroomViewControllerDelegate?
    
    // 课堂名称（输入框）
    lazy var nameView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholderString = "请输入课堂名称"
        return view
    }()
    // 教师密码
    lazy var tPasswordView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholderString = "请输入教师登录密码"
        view.optionLabel.isHidden = false
        return view
    }()
    // 学生密码
    lazy var sPasswordView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholderString = "请输入学生登录密码"
        view.optionLabel.isHidden = false
        return view
    }()
    // 课程时长
    lazy var timeView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholderString = "请输入课程时长（分），默认60分"
        view.optionLabel.isHidden = false
        return view
    }()

    /// 自动录制
    lazy var autoRecordButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapRecordButton(sender:))
        button.attributedTitle(text: "自动录制", color: .black)
        button.font = NSFont.systemFont(ofSize: 14)
        // 类型
        button.setButtonType(.radio)
        // 按钮状态
        button.state = .off
        // 样式
        button.bezelStyle = .texturedSquare
        return button
    }()
    /// 手动录制
    lazy var manualRecordButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapRecordButton(sender:))
        button.attributedTitle(text: "手动录制", color: .black)
        button.font = NSFont.systemFont(ofSize: 14)
        // 类型
        button.setButtonType(.radio)
        // 按钮状态
        button.state = .off
        // 样式
        button.bezelStyle = .texturedSquare
        return button
    }()
    /// 不录制
    lazy var notRecordButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapRecordButton(sender:))
        button.attributedTitle(text: "不录制", color: .black)
        button.font = NSFont.systemFont(ofSize: 14)
        // 类型
        button.setButtonType(.radio)
        // 按钮状态
        button.state = .on
        // 样式
        button.bezelStyle = .texturedSquare
        return button
    }()
    /// 1自动（默认） 2手动 3不录
    var recMethod:Int = 3
    @objc func tapRecordButton(sender:NSButton) {
        switch sender {
        case autoRecordButton: do {
            recMethod = 1
        }
        case manualRecordButton: do {
            recMethod = 2
        }
        case notRecordButton: do {
            recMethod = 3
        }
        default:break
        }
    }
    
    // 确定按钮
    lazy var doneButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapDoneButton(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .inline
        // 属性字符
        button.attributedTitle(text: "确定", color: color_Theme1)
        return button
    }()
    @objc func tapDoneButton(sender:NSButton) {
        createCourse()
    }

    // 创建课
    func createCourse() {
        if nameView.textField.stringValue.count > 0 {
            let name = nameView.textField.stringValue
            let appId:String = APPSingleton.shared.QMAPPID
            let tPassword = tPasswordView.textField.stringValue
            let sPassword = sPasswordView.textField.stringValue
//            //FIXME: 暂时固定不录制，防止跑流量
//            recMethod = 3
            let courseOptions:[String:Any] = ["recMethod":recMethod,
                                             "openClassReminder":"y",
                                             "callbackUrl":"http://jledu.f3322.net:9208/live/test/callback"]
            APPSingleton.shared.requestCreateCourse(appId: appId,
                                                    courseName: name,
                                                    teacherPwd: tPassword,
                                                    studentPwd: sPassword,
                                                    startTime: "",
                                                    endTime: "",
                                                    courseOptions: courseOptions) { (isSuccess, data, message, error) in
                if isSuccess == true {
                    let alert = NSAlert()
                    alert.addButton(withTitle: "确定")
                    alert.addButton(withTitle: "取消")
                    alert.messageText = "提示"
                    alert.informativeText = "课程创建成功"
                    alert.alertStyle = .informational
                    alert.beginSheetModal(for: self.view.window!) { response in
                        self.delegate?.createClassroomDidDone()
                        self.backUpPage()
                    }
                }
                else {
                    let alert = NSAlert()
                    alert.addButton(withTitle: "确定")
                    alert.messageText = "提示"
                    alert.informativeText = "课程创建失败"
                    alert.alertStyle = .critical
                    alert.beginSheetModal(for: self.view.window!) { response in
                        AppPrint(response.rawValue)
                    }
                }
            }
        }
        else {
            let alert = NSAlert()
            alert.addButton(withTitle: "确定")
            alert.messageText = "提示"
            alert.informativeText = "课堂名称不能为空"
            alert.alertStyle = .informational
            alert.beginSheetModal(for: self.view.window!) { response in
                AppPrint(response.rawValue)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.titleLabel.stringValue = "创建课"
        createUI()
    }
    func createUI() {
        view.addSubview(nameView)
        nameView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        view.addSubview(tPasswordView)
        tPasswordView.snp.makeConstraints { make in
            make.top.equalTo(nameView.snp.bottom).offset(20)
            make.left.equalTo(nameView)
            make.right.equalTo(nameView)
            make.height.equalTo(nameView)
        }
        
        view.addSubview(sPasswordView)
        sPasswordView.snp.makeConstraints { make in
            make.top.equalTo(tPasswordView.snp.bottom).offset(20)
            make.left.equalTo(nameView)
            make.right.equalTo(nameView)
            make.height.equalTo(nameView)
        }
        
        view.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.top.equalTo(sPasswordView.snp.bottom).offset(20)
            make.left.equalTo(nameView)
            make.right.equalTo(nameView)
            make.height.equalTo(nameView)
        }
        
        // 手动录制
        view.addSubview(manualRecordButton)
        manualRecordButton.snp.makeConstraints { make in
            make.top.equalTo(timeView.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.height.equalTo(30)
            make.width.equalTo(view.snp.width).multipliedBy(0.22)
        }
        
        // 自动录制
        view.addSubview(autoRecordButton)
        autoRecordButton.snp.makeConstraints { make in
            make.top.equalTo(manualRecordButton)
            make.right.equalTo(manualRecordButton.snp.left).offset(-25)
            make.size.equalTo(manualRecordButton)
        }

        // 不录制
        view.addSubview(notRecordButton)
        notRecordButton.snp.makeConstraints { make in
            make.top.equalTo(manualRecordButton)
            make.left.equalTo(manualRecordButton.snp.right).offset(25)
            make.size.equalTo(manualRecordButton)
        }
        
        // 确定按钮
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(notRecordButton.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
    }
    
}
