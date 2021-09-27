//
//  LoginViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/18.
//

import Cocoa

class LoginViewController: NSViewController {

    /// 设置按钮
    lazy var setingButton: NSButton = {
        let button = NSButton(image: NSImage(named: "登录设置")!,
                              target: self,
                              action: #selector(tapSetingButton(sender:)))
        button.imagePosition = .imageOnly
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.isBordered = false
        return button
    }()
    @objc func tapSetingButton(sender:NSButton) {
        let VC = SetClassroomViewController()
        VC.delegate = self
        
         self.present(VC, animator: PresentAnimator())
        
        // self.presentAsModalWindow(VC)
        
        //self.presentAsSheet(VC)
        
       //  self.present(VC, asPopoverRelativeTo: sender.frame, of: self.view, preferredEdge: .minY, behavior: .transient)

//        self.addChild(VC)
//        view.addSubview(VC.view)
//        VC.view.snp.makeConstraints { make in
//            make.edges.equalTo(NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
//        }
    }
    
    /// 分享按钮
    lazy var shareButton: NSButton = {
        let button = NSButton(image: NSImage(named: "登录分享")!,
                              target: self,
                              action: #selector(tapShareButton(sender:)))
        button.imagePosition = .imageOnly
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.isBordered = false
        return button
    }()
    @objc func tapShareButton(sender:NSButton) {
        
    }

    /// 昵称
    lazy var infoLabel: APPLabel = {
        let label = APPLabel()
        label.text = "用户id：（昵称）"
        return label
    }()
    
    /// logo
    lazy var logoView: NSImageView = {
        let view = NSImageView()
        view.image = NSImage(named: "icon")
        /// 使用layer来管理呈现的内容
        view.wantsLayer = true
        view.layer?.cornerRadius = 30
        view.layer?.masksToBounds = true
        return view
    }()
    
    /// 标题
    lazy var titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "腾视直播")
        label.isEditable = false
        label.textColor = .black
        label.font = NSFont.systemFont(ofSize: 20)
        // 边框
        label.isBordered = true
        // 边框
        label.isBezeled = false
        // 对齐方式
        label.alignment = .center
        //最多显示行数
        label.maximumNumberOfLines = 1
        return label
    }()
    
    /// 课堂编号
    lazy var numberField: APPCenterTextFieldView = {
        let view = APPCenterTextFieldView()
        let field = view.textField
        field.delegate = self
        field.placeholderString = "请输入课堂编号"
        field.textColor = .black
        field.isEnabled = true
        return view
    }()
    
    /// 课堂密码
    lazy var passwordField: APPCenterTextFieldView = {
        let view = APPCenterTextFieldView()
        let field = view.textField
        field.placeholderString = "请输入课堂密码"
        field.textColor = .black
        field.isEnabled = true
        return view
    }()
    
    /// 学生（单选按钮）
    lazy var studentButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapRoleButton(sender:))
        button.attributedTitle(text: "学生", color: .black)
        button.font = NSFont.systemFont(ofSize: 14)
        // 类型
        button.setButtonType(.radio)
        // 按钮状态
        button.state = .off
        // 样式
        button.bezelStyle = .texturedSquare
        button.isHidden = true
        return button
    }()
    
    /// 老师（单选按钮）
    lazy var teacherButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapRoleButton(sender:))
        button.attributedTitle(text: "教师", color: .black)
        button.font = NSFont.systemFont(ofSize: 14)
        // 类型
        button.setButtonType(.radio)
        // 按钮状态
        button.state = .on
        // 样式
        button.bezelStyle = .texturedSquare
        button.isHidden = true
        return button
    }()
    
    /// 角色
    enum Role:String {
        case teacher = "t"
        case student = "s"
    }
    var role:Role = .teacher
    /// 角色切换
    @objc func tapRoleButton(sender:NSButton) {
        role = (sender == teacherButton ? .teacher : .student)
    }
    
    // 课堂名称
    lazy var classNameLabel: APPLabel = {
        let view = APPLabel()
        view.text = "课堂名称"
        return view
    }()
    // 课堂状态
    lazy var stateLabel: NSTextField = {
        let label = NSTextField()
        label.isEditable = false
        label.stringValue = "上课中"
        label.textColor = color_Theme1
        label.font = NSFont.systemFont(ofSize: 14)
        // 黑色边框
        label.isBordered = false
        // 边框背景
        label.isBezeled = true
        label.bezelStyle = .roundedBezel
        // 对齐方式
        label.alignment = .center
        //最多显示行数
        label.maximumNumberOfLines = 1
        label.backgroundColor = color_green2
        return label
    }()

    /// 进入课堂按钮
    lazy var joinButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapJoinButton(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .regularSquare
        // 属性字符
        button.attributedTitle(text: "进入课堂", color: color_Theme1)
        return button
    }()
    @objc func tapJoinButton(sender:NSButton) {
        // 注册用户
        registUser()
    }
    
    // 创建课堂（按钮）
    lazy var createButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapCreateButton(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .regularSquare
        // 属性字符
        button.attributedTitle(text: "创建课堂", color: color_Theme1)
        return button
    }()
    @objc func tapCreateButton(sender:NSButton) {
        let VC = CreateClassroomViewController()
        VC.delegate = self
        self.present(VC, animator: PresentAnimator())
    }
    
    // 查看历史课程（按钮）
    lazy var historyButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapHistoryButton(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .inline
        // 属性字符
        button.title = "查看历史课程"
        //button.attributedTitle(text: "查看历史课程", color: .black)
        return button
    }()
    @objc func tapHistoryButton(sender:NSButton) {
        let VC = HistoryCourseViewController()
        VC.userId = APPSingleton.shared.userId
        self.present(VC, animator: PresentAnimator())
    }
    
    /// 导入学生
    lazy var importButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapImportButton(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .inline
        // 属性字符
        button.title = "批量导入学生"
        return button
    }()
    @objc func tapImportButton(sender:NSButton) {
        addStudents(students: [[ : ]])
    }
    // 导入学生信息
    func addStudents(students:[[String:Any]]) {
        var tempStudents:[[String:Any]] = []
        for i in 0 ..< 32 {
            var student:[String:Any] = [:]
            student["id"] = 400+i
            student["avatarUrl"] = ""
            student["nickName"] = "学生昵称\(i)"
            student["expValue"] = 100
            tempStudents.append(student)
        }
        
        ///网络请求
        let manager = APPNetWorkingManager()
        var parameters:[String:Any] = [:]
        parameters["students"] = tempStudents
        parameters["courseId"] = APPSingleton.shared.QMCourseId
        AppPrint(JSONSerialization.JSONString(object: parameters))
        manager.POSTRequest(URLString: INTERFACE_addStudents,
                            parameters: &parameters,
                            token: APPSingleton.shared.QMToken) { (requestData) in
            AppPrint(JSONSerialization.JSONString(object: requestData))
            NSAlert.showInfo(window: self.view.window, title: "导入成功", content: "")
        } failure: { (error) in
            NSAlert.showInfo(window: self.view.window, title: "导入失败", content: error.debugDescription)
        }
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        updateUI()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    /// 刷新视图
    func updateUI() {
        if APPSingleton.shared.nickname.count>0 ||
            APPSingleton.shared.userId>0 {
            infoLabel.text = "用户ID："+String(APPSingleton.shared.userId)+"(\(APPSingleton.shared.nickname))"
        }
        else {
            infoLabel.text = "未设置"
        }
        if APPSingleton.shared.QMCourseId>0 {
            numberField.textField.stringValue = String(APPSingleton.shared.QMCourseId)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.window?.setIsZoomed(false)
//        self.view.needsDisplay = true
        view.window?.isRestorable = false

        createUI()
        
        updateLogoName()
        
        if String(APPSingleton.shared.QMCourseId).count > 0 {
            checkClassState(courseId: String(APPSingleton.shared.QMCourseId))
        }
    }
    
    func createUI() {

        // 设置按钮
        view.addSubview(setingButton)
        setingButton.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.right.equalTo(-10)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        // 分享按钮
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.size.equalTo(setingButton)
            make.top.equalTo(setingButton)
            make.right.equalTo(setingButton.snp.left).offset(-15)
        }
        // 用户信息
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(setingButton)
            make.height.equalTo(20)
            make.left.equalTo(15)
            make.right.equalTo(shareButton.snp.left)
        }
        
        
        // logo
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 60, height: 60))
            make.top.equalTo(50)
            make.centerX.equalTo(view)
        }
        // 标题
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoView.snp.bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        
        // 课堂编号
        view.addSubview(numberField)
        numberField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.height.equalTo(40)
            make.left.equalTo(30)
            make.right.equalTo(-30)
        }


        // 学生按钮
        view.addSubview(studentButton)
        studentButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.centerX).offset(10)
            make.bottom.equalTo(numberField.snp.top)
            make.width.equalTo(numberField).multipliedBy(0.2)
            make.height.equalTo(40)
        }
        // 老师按钮
        view.addSubview(teacherButton)
        teacherButton.snp.makeConstraints { make in
            make.right.equalTo(studentButton.snp.left)
            make.size.equalTo(studentButton)
            make.bottom.equalTo(studentButton)
        }

        // 密码输入框
        view.addSubview(passwordField)
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(numberField.snp.bottom).offset(50)
            make.left.equalTo(numberField)
            make.right.equalTo(numberField)
            make.height.equalTo(numberField)
        }
        // 课堂状态
        view.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.top.equalTo(numberField.snp.bottom).offset(5)
            make.width.equalTo(100)
            make.right.equalTo(numberField)
            make.height.equalTo(30)
        }
        
        // 课堂名称
        view.addSubview(classNameLabel)
        classNameLabel.snp.makeConstraints { make in
            make.top.equalTo(numberField.snp.bottom).offset(10)
            make.left.equalTo(numberField)
            make.right.equalTo(stateLabel.snp.left).offset(-20)
            make.height.equalTo(20)
        }
        
        // 创建课堂
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(view).multipliedBy(0.4)
            make.left.equalTo(30)
        }
        
        // 进入课堂按钮
        view.addSubview(joinButton)
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(40)
            make.height.equalTo(40)
            make.width.equalTo(view).multipliedBy(0.4)
            make.right.equalTo(-30)
        }
        
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 99, height: 30))
            make.centerX.equalTo(view)
        }
        
        view.addSubview(importButton)
        importButton.snp.makeConstraints { make in
            make.top.equalTo(historyButton.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 99, height: 30))
            make.centerX.equalTo(view)
        }
    }
    /// 设置状态
    /// - Parameter text: 文本
    func setClassStatus(text:String) {
        self.stateLabel.stringValue = text

    }

    /// 查询课堂状态
    func checkClassState(courseId:String) {
        APPSingleton.shared.requestGetCourseParam(courseId: courseId) { isSuccess, data, message, error in
            if isSuccess == true {
                // 课堂状态
                if let status = data?["status"] as? Int{
                    let text = QMTool.statusChangeToText(status: status)
                    self.setClassStatus(text: text)
                    if status == 1 ||
                        status == 0 {
                        self.joinButton.isEnabled = true
                    }
                    else {
                        self.joinButton.isEnabled = false
                    }
                }
                else {
                    self.joinButton.isEnabled = false
                }
                // 课堂名称
                if let courseName = data?["courseName"] as? String {
                    self.classNameLabel.text = courseName
                    APPSingleton.shared.QMCourseName = courseName
                }
                else {
                    self.classNameLabel.text = "课堂名称：无"
                    APPSingleton.shared.QMCourseName = ""
                }
                // 创建时间
                if let startTime = data?["startTime"] as? String {
                    APPSingleton.shared.QMStartTime = startTime
                }
            }
            else {
                self.joinButton.isEnabled = false
                self.classNameLabel.text = message
                self.setClassStatus(text: "未知")
            }
            self.updatePassword()
        }
    }
    
    //
    func updatePassword() {
        if role == .teacher {
            passwordField.textField.stringValue = APPSingleton.shared.tPassword
        }
        else {
            passwordField.textField.stringValue = APPSingleton.shared.sPassword
        }
    }
    
    /// 注册用户（这里成功后会得到token）
    func registUser() {
        let userid = APPSingleton.shared.userId
        let courseId:Int = APPSingleton.shared.QMCourseId
        let password:String = passwordField.textField.stringValue
        APPSingleton.shared.requestRegistUser(userid: userid,
                                                courseId: courseId,
                                                password: password,
                                                nickName: APPSingleton.shared.nickname,
                                                role: role.rawValue,
                                                avatarUrl: APPSingleton.shared.userLogo,
                                                deviceToken: APPSingleton.shared.deviceToken,
                                                originExpValue: 0) { (isSuccess, data, message, error) in
            if isSuccess == true {
                self.qmJoinClassroom()
            }
            else {
                NSAlert.showCritical(window: self.view.window, title: "提示", content: "注册或登录失败")
            }
        }
    }
    
    /// 通用链接
    func appURL() -> URL? {
        //调起课堂APP token作为传递参数
        let urlString = "https://stu-link.jledu.com/qmschoolMac/teacher/open/?" + "parameter=" + APPSingleton.shared.QMToken
        return URL(string: urlString)
    }
    
    //MARK: 进入课堂
    func qmJoinClassroom() {
        AppPrint(APPSingleton.shared.QMToken)
        if APPSingleton.shared.QMToken.count>0 {

            if let strongAppURL = appURL() {
                if #available(macOS 10.15, *) {
                    let configuration = NSWorkspace.OpenConfiguration()
                    // 一个布尔值，指示您是否要打印文档和 URL 的内容而不是打开它们。
                    configuration.isForPrinting = false
                    // 一个布尔值，指示您是否要求 URL 具有关联的通用链接。
                    configuration.requiresUniversalLinks = true
                    // 一个布尔值，指示系统是否激活应用程序并将其置于前台。
                    configuration.activates = true
                    // 一个布尔值，指示您是否希望系统启动应用程序的新实例。
                    configuration.createsNewApplicationInstance = false
                    // 一个布尔值，指示是否向用户显示错误、身份验证请求或其他 UI 元素。
                    configuration.promptsUserIfNeeded = false
                    // 一个布尔值，指示是否使用正在运行的应用程序实例，即使它位于不同的 URL。
                    configuration.allowsRunningApplicationSubstitution = true
                    // 这给你的路径到应用程序文件夹（/应用程序和〜/应用）
                    if let path = FileManager.default.urls(for: .applicationDirectory, in: .localDomainMask).first?.appendingPathComponent("腾视直播.app") {
                        NSWorkspace.shared.open([strongAppURL],
                                                withApplicationAt: path,
                                                configuration: configuration) { app, error in
                            guard error == nil else {
                                print("打开失败")
                                //直接打开
                                self.gotoLowVersionURL()
                                return
                            }
                            print("打开成功")
                            // 到主线程
                            DispatchQueue.main.async {
                                NSApp.hide(nil)
                            }
                        }
                    }else {
                        gotoLowVersionURL()
                    }
                } else {
                    // 10.14以下是用直接跳转
                    gotoLowVersionURL()
                }
            }
        }
        else {
            NSAlert.showCritical(window: self.view.window, title: "提示", content: "Token为空")
        }
    }
    //MARK: 低版本方式跳转(不指定app路径)
    func gotoLowVersionURL() {
        if let strongAppURL = appURL() {
            let result = NSWorkspace.shared.open(strongAppURL)
            if result == false {
                // 显示到下载页
                if let lastURL =  URL(string: "https://school.jledu.com/#/product") {
                    NSWorkspace.shared.open(lastURL)
                }
            }
            else {
                // 到主线程
                DispatchQueue.main.async {
                    NSApp.hide(nil)
                }
            }
        }
    }
    
    func updateLogoName() {
        
        if APPSingleton.shared.QMAPPID.count>0 &&
            APPSingleton.shared.QMAPPSecret.count>0 {
            APPSingleton.shared.requestGetAppInfo { isSuccess, data, message, error in
                let appLogo = data?["appLogo"] as? String ?? ""
                let appName = data?["appName"] as? String ?? ""
                self.logoView.sd_setImage(with: URL(string: appLogo),
                                            placeholderImage: NSImage(named: "Default_UserAvatar"))
                self.titleLabel.stringValue = appName
            }
        }
    }
}

extension LoginViewController: SetClassroomViewControllerDelegate {
    func setClassroomVCDidBack() {
        updateUI()
        updateLogoName()
    }
}

extension LoginViewController: CreateClassroomViewControllerDelegate {
    func createClassroomDidDone() {
        updateUI()
        checkClassState(courseId: String(APPSingleton.shared.QMCourseId))
    }
}

extension LoginViewController: NSTextFieldDelegate {
    
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        
        if commandSelector == #selector(insertNewline(_:)) {
            if let modifierFlags = NSApplication.shared.currentEvent?.modifierFlags, (modifierFlags.rawValue & NSEvent.ModifierFlags.shift.rawValue) != 0 {
                AppPrint("Shift-Enter detected.")
                textView.insertNewlineIgnoringFieldEditor(self)
                return true
            } else {
                AppPrint("Enter detected.")
            }
        }
        return false
    }

    func controlTextDidChange(_ obj: Notification) {
        if self.numberField.textField.stringValue.count>0 {
            checkClassState(courseId: self.numberField.textField.stringValue)
        }
    }
}




