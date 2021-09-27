//
//  APPTextFieldViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

@objc protocol APPTextFieldViewControllerDelegate : NSObjectProtocol {
    /// 返回的文本
    @objc func appTextFieldDidReturn(text:String, sign:Int, indexPaht:IndexPath)
}


class APPTextFieldViewController: BaseViewController {
    
    weak var delegate:APPTextFieldViewControllerDelegate?
    
    var sign:Int = 0
    var indexPath:IndexPath = IndexPath(item: 0, section: 0)
    
    lazy var textField: NSTextField = {
        let field = NSTextField()
        field.isEnabled = true
        field.placeholderString = "请输入信息"
        field.isBordered = true
        field.isBezeled = true
        field.bezelStyle = .squareBezel
        field.textColor = .black
        field.font = NSFont.systemFont(ofSize: 14)
        field.backgroundColor = .white
        // 对齐方式
        field.alignment = .left
        field.maximumNumberOfLines = 0
        return field
    }()
    
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
        self.backUpPage()
        self.delegate?.appTextFieldDidReturn(text: self.textField.stringValue,
                                             sign: sign,
                                             indexPaht: indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(100)
        }
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(60)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
    }
}
