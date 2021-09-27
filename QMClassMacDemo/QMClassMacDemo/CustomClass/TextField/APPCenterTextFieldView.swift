//
//  APPCenterTextFieldView.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/22.
//

import Cocoa

class APPCenterTextFieldView: NSView {
    
    /// 课堂编号
    lazy var textField: APPTextField = {
        let field = APPTextField()
        field.isBordered = true
        // 边框
        field.isBezeled = false
        field.placeholderString = ""
        field.textColor = .black
        field.font = NSFont.systemFont(ofSize: 14)
        field.backgroundColor = .clear
        // 对齐方式
        field.alignment = .left
        field.isEnabled = true
        return field
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = .white
        self.layer?.borderColor = color_Theme1.cgColor
        self.layer?.borderWidth = 1
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds = true
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(10)
            make.right.equalTo(10)
            make.height.equalTo(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
}
