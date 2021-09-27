//
//  SetClassroomViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa
import SDWebImage

@objc protocol SetClassroomViewControllerDelegate : NSObjectProtocol {
    ///
    @objc func setClassroomVCDidBack()
}

/// 课程设置
class SetClassroomViewController: BaseViewController {
    
    weak var delegate:SetClassroomViewControllerDelegate?
    
    /// 头像底图
    lazy var avatarView: NSButton = {
        let button = NSButton()
        button.title = ""
        button.target = self
        button.action = #selector(tapAvatar(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .rounded
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.cornerRadius = 5
        button.layer?.masksToBounds = true
        button.layer?.backgroundColor = .white
        return button
    }()
    @objc func tapAvatar(sender:NSButton) {
        let VC = AvatarListViewController()
        VC.titleLabel.stringValue = "选择头像"
        VC.delegate = self
        self.present(VC, animator: PresentAnimator())
    }
    
    /// 头像视图
    lazy var avatarImageView: NSImageView = {
        let view = NSImageView()
        view.sd_setImage(with: URL(string: APPSingleton.shared.userLogo),
                         placeholderImage: NSImage(named: "Default_UserAvatar"))
        /// 使用layer来管理呈现的内容
        view.wantsLayer = true
        view.layer?.cornerRadius = 15
        view.layer?.masksToBounds = true
        return view
    }()
    
    /// 昵称
    lazy var nickNameView: NSButton = {
        let button = NSButton()
        button.title = ""
        button.target = self
        button.action = #selector(tapNickName(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .rounded
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.cornerRadius = 5
        button.layer?.masksToBounds = true
        button.layer?.backgroundColor = .white
        return button
    }()
    @objc func tapNickName(sender:NSButton) {
        let VC = APPTextFieldViewController()
        VC.delegate = self
        VC.titleLabel.stringValue = "输入昵称"
        self.present(VC, animator: PresentAnimator())
    }
    
    lazy var nickNameLabel: NSTextField = {
        let label = NSTextField(labelWithString: APPSingleton.shared.nickname)
        label.placeholderString = "无"
        label.backgroundColor = .white
        label.alignment = .right
        //最多显示行数
        label.maximumNumberOfLines = 1
        // 设置断行模式
        label.cell?.lineBreakMode = .byTruncatingTail
        // 设置是否启用单行模式
        label.cell?.usesSingleLineMode = true
        // 设置超出行数是否隐藏
        label.cell?.truncatesLastVisibleLine = true
        return label
    }()
    
    // 应用id（输入框）
    lazy var appIdView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholderString = "请输入ID"
        return view
    }()
    // 应用秘钥 （输入框）
    lazy var appSecretView: CombinationTextFieldView = {
        let view = CombinationTextFieldView()
        view.textField.placeholderString = "请输入密钥"
        return view
    }()
    
    // 测试按钮
    lazy var testButton: NSButton = {
        let button = NSButton()
        button.target = self
        button.action = #selector(tapTestButton(sender:))
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.bezelStyle = .inline
        // 属性字符
        button.attributedTitle(text: "测试", color: color_Theme1)
        return button
    }()
    @objc func tapTestButton(sender:NSButton) {
        sender.isEnabled = false
        APPSingleton.shared.requestGetAppInfo { isSuccess, data, message, error in
            if isSuccess == true {
                let alert = NSAlert()
                alert.addButton(withTitle: "确定")
                alert.messageText = "提示"
                alert.informativeText = "应用ID和秘钥验证成功"
                alert.alertStyle = .informational
                alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
            }
            else {
                let alert = NSAlert()
                alert.addButton(withTitle: "确定")
                alert.messageText = "提示"
                alert.informativeText = "应用ID和秘钥验证失败"
                alert.alertStyle = .informational
                alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
            }
            sender.isEnabled = true
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
        // 生成8位随机数
        let random = Int(arc4random_uniform(90000000) + 10000000)
        APPSingleton.shared.userId = random
        self.backUpPage()
    }
    
    /// 返回上一页(重载)
    @objc override func backUpPage() {
        self.delegate?.setClassroomVCDidBack()
        super.backUpPage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APPSingleton.shared.QMAPPID = APP_KEY
        appIdView.textField.stringValue = APPSingleton.shared.QMAPPID
        APPSingleton.shared.QMAPPSecret = APP_SECRET
        appSecretView.textField.stringValue = APPSingleton.shared.QMAPPSecret
        
        createUI()
    }
    
    func createUI() {
        self.titleLabel.stringValue = "设置"
        // 头像
        view.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        let avatarLabel = NSTextField(labelWithString: "头像")
        avatarLabel.backgroundColor = .white
        avatarLabel.sizeToFit()
        avatarView.addSubview(avatarLabel)
        avatarLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarView)
            make.left.equalTo(15)
            make.width.equalTo(60)
        }
        let arrow1 = NSImageView()
        arrow1.image = NSImage(named: "右箭头")
        /// 使用layer来管理呈现的内容
        avatarView.addSubview(arrow1)
        arrow1.snp.makeConstraints { make in
            make.centerY.equalTo(avatarView)
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.right.equalTo(-5)
        }
        avatarView.addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.right.equalTo(arrow1.snp.left).offset(-5)
            make.centerY.equalTo(avatarView.snp.centerY)
        }
        // 昵称
        view.addSubview(nickNameView)
        nickNameView.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(15)
            make.left.equalTo(avatarView)
            make.right.equalTo(avatarView)
            make.height.equalTo(avatarView)
        }
        let tempNickNameLabel = NSTextField(labelWithString: "昵称")
        tempNickNameLabel.backgroundColor = .white
        tempNickNameLabel.sizeToFit()
        nickNameView.addSubview(tempNickNameLabel)
        tempNickNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nickNameView)
            make.left.equalTo(15)
            make.width.equalTo(60)
        }
        let arrow2 = NSImageView()
        arrow2.image = NSImage(named: "右箭头")
        /// 使用layer来管理呈现的内容
        nickNameView.addSubview(arrow2)
        arrow2.snp.makeConstraints { make in
            make.centerY.equalTo(nickNameView)
            make.width.equalTo(15)
            make.height.equalTo(15)
            make.right.equalTo(-5)
        }
        nickNameLabel.sizeToFit()
        nickNameView.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nickNameView)
            make.right.equalTo(nickNameView.snp.right).offset(-25)
            make.left.equalTo(tempNickNameLabel.snp.right)
        }
        // 应用ID
        view.addSubview(appIdView)
        appIdView.snp.makeConstraints { make in
            make.top.equalTo(nickNameView.snp.bottom).offset(15)
            make.right.equalTo(nickNameView.snp.right)
            make.left.equalTo(nickNameView.snp.left).offset(100)
            make.height.equalTo(40)
        }
        let appIdLabel = NSTextField(labelWithString: "应用ID")
        appIdLabel.backgroundColor = .white
        appIdLabel.sizeToFit()
        view.addSubview(appIdLabel)
        appIdLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appIdView)
            make.left.equalTo(35)
        }
        // 应用密钥
        view.addSubview(appSecretView)
        appSecretView.snp.makeConstraints { make in
            make.top.equalTo(appIdView.snp.bottom).offset(15)
            make.right.equalTo(nickNameView.snp.right)
            make.left.equalTo(nickNameView.snp.left).offset(100)
            make.height.equalTo(40)
        }
        let appSecretLabel = NSTextField(labelWithString: "应用密钥")
        appSecretLabel.backgroundColor = .white
        appSecretLabel.sizeToFit()
        view.addSubview(appSecretLabel)
        appSecretLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appSecretView)
            make.left.equalTo(35)
        }
        // 测试按钮
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.top.equalTo(appSecretView.snp.bottom).offset(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(40)
        }
        // 确定按钮
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(testButton.snp.bottom).offset(15)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(40)
        }
    }
}

extension SetClassroomViewController: APPTextFieldViewControllerDelegate {
    
    func appTextFieldDidReturn(text: String, sign: Int, indexPaht: IndexPath) {
        APPSingleton.shared.nickname = text
        self.nickNameLabel.stringValue = text
    }
}

extension SetClassroomViewController: AvatarListViewControllerDelegate {
    func avatarListDidSelected(imageURL: String) {
        APPSingleton.shared.userLogo = imageURL
        avatarImageView.sd_setImage(with: URL(string: imageURL),
                                    placeholderImage: NSImage(named: "Default_UserAvatar"))
    }
}
