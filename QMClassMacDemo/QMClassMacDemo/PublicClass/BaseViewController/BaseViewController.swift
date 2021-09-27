//
//  BaseViewController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

class BaseViewController: NSViewController {
    
    /// 返回按钮
    lazy var backButton: NSButton = {
        let button = NSButton(image: NSImage(named: "返回-黑")!,
                              target: self,
                              action: #selector(backUpPage))
        button.imagePosition = .imageOnly
        // 类型
        button.setButtonType(.momentaryPushIn)
        // 样式
        button.isBordered = false
        return button
    }()
    /// 返回上一页
    @objc func backUpPage() {
        // 到主线程刷新UI 
        DispatchQueue.main.async {
            self.dismiss(nil)
        }
    }

    lazy var titleLabel: NSTextField = {
        let label = NSTextField(labelWithString: "")
        label.isEditable = false
        label.textColor = .black
        label.font = NSFont.systemFont(ofSize: 16)
        // 边框
        label.isBordered = true
        // 边框
        label.isBezeled = false
        // 对齐方式
        label.alignment = .center
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
    
    override func loadView() {
        // 设置 ViewController 大小同 mainWindow
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
        view.wantsLayer = true
        view.layer?.backgroundColor = color_gray2.cgColor
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(backButton.snp.right)
            make.right.equalTo(view.snp.right).offset(-60)
            make.height.equalTo(30)
        }
    }
}
