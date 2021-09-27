//
//  CombinationTextFieldView.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

class CombinationTextFieldView: NSView {

    /// 输入框
    lazy var textField: APPTextField = {
        let field = APPTextField()
        field.isBordered = true
        // 边框
        field.isBezeled = false
        field.placeholderString = ""
        field.textColor = .black
        field.font = NSFont.systemFont(ofSize: 14)
        field.backgroundColor = .white
        // 对齐方式
        field.alignment = .left
        field.isEnabled = true
        return field
    }()
    
    lazy var optionLabel: NSTextField = {
        let field = NSTextField(labelWithString: "（选填）")
        field.isBordered = false
        // 边框
        field.isBezeled = false
        field.textColor = QMColor_Text
        field.font = NSFont.systemFont(ofSize: 14)
        field.backgroundColor = .white
        // 对齐方式
        field.alignment = .left
        field.isEnabled = false
        field.isHidden = true
        return field
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = .white
        self.layer?.cornerRadius = 5
        self.layer?.masksToBounds = true
        
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(10)
            make.right.equalTo(10)
            make.height.equalTo(20)
        }
        optionLabel.sizeToFit()
        addSubview(optionLabel)
        optionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.right.equalTo(-10)
            make.width.equalTo(40).priority(500)
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
