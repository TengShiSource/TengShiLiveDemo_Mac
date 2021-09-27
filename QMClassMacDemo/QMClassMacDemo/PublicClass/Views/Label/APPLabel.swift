//
//  APPLabel.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/22.
//

import Cocoa

class APPLabel: NSView {
    
    var text:String? {
        didSet {
            if let sText = text {
                textField.stringValue = sText
            }
            else {
                textField.stringValue = ""
            }
        }
    }
    var attributedText:String? {
        didSet {
            if let sAttributedtext = attributedText {
                textField.attributedStringValue = NSAttributedString(string: sAttributedtext, attributes: [NSAttributedString.Key.foregroundColor : NSColor.black])
            }
            else {
                textField.attributedStringValue = NSAttributedString(string: "", attributes: [NSAttributedString.Key.foregroundColor : NSColor.black])
            }
        }
    }
    func setAttributed(text:String,textColor:NSColor) {
        textField.attributedStringValue = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor : textColor])
    }
    lazy var textField: APPTextField = {
        let field = APPTextField()
        field.isBordered = true
        // 边框
        field.isBezeled = false
        field.textColor = .black
        field.font = NSFont.systemFont(ofSize: 14)
        field.backgroundColor = .clear
        // 对齐方式
        field.alignment = .left
        field.isEnabled = false
        //最多显示行数
        field.maximumNumberOfLines = 1
        // 设置断行模式
        field.cell?.lineBreakMode = .byTruncatingTail
        // 设置是否启用单行模式
        field.cell?.usesSingleLineMode = true
        // 设置超出行数是否隐藏
        field.cell?.truncatesLastVisibleLine = true
        return field
    }()
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = .white
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.height.equalTo(18)
            make.width.equalTo(self).offset(-10)
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

