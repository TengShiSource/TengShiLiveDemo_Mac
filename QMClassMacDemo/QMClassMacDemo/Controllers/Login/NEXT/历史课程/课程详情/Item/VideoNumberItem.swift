//
//  VideoNumberItem.swift
//  QMClassMac
//
//  Created by penguin on 2021/8/6.
//

import Cocoa

class VideoNumberModel {
    var title:String = ""
    var isSelected:Bool = false
    var videoUrl:String = ""
    init(title:String,
         isSelected:Bool,
         videoUrl:String) {
        self.title = title
        self.isSelected = isSelected
        self.videoUrl = videoUrl
    }
}

class VideoNumberItem: NSCollectionViewItem {
    
    lazy var label: NSTextField = {
        let label = NSTextField(labelWithString: "")
        label.placeholderString = ""
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
    
    var model:VideoNumberModel? {
        didSet {
            if let cellModel = model {
                label.stringValue = cellModel.title
                if cellModel.isSelected == true {
                    label.layer?.backgroundColor = #colorLiteral(red: 0.9121555686, green: 0.9691887498, blue: 0.9528110623, alpha: 1)
                    label.textColor = color_Theme1
                }
                else {
                    label.layer?.backgroundColor = #colorLiteral(red: 0.9605508447, green: 0.9646353126, blue: 0.9727998376, alpha: 1)
                    label.textColor = .black
                }
            }
        }
    }
    
    override func loadView() {
        self.view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.height.equalTo(18)
            make.width.equalTo(view).offset(-10)
        }
    }
}
