//
//  HistoryCourseItem.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/25.
//

import Cocoa

class HistoryCourseItem: NSCollectionViewItem {
    
    lazy var bottomView: NSView = {
        let view = NSView()
        view.layer?.backgroundColor = .white
        view.layer?.cornerRadius = 5
        view.layer?.masksToBounds = true
        return view
    }()
    
    // 课程名称
    lazy var courseNameLabel: NSTextField = {
        let label = NSTextField(wrappingLabelWithString: "")
        label.isSelectable = false
        label.textColor = .black
        label.alignment = .left
        label.font = NSFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    // 时间🕒
    lazy var timeLabel: NSTextField = {
        let label = NSTextField(wrappingLabelWithString: "")
        label.isSelectable = false
        label.textColor = .gray
        label.alignment = .left
        label.font = NSFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 头像
    lazy var pictureView: NSImageView = {
        let view = NSImageView()
        view.imageScaling = .scaleProportionallyUpOrDown
        view.wantsLayer = true
        return view
    }()
    
    // 授课人
    lazy var nameLabel: NSTextField = {
        let label = NSTextField(wrappingLabelWithString: "")
        label.isSelectable = false
        label.textColor = .gray
        label.alignment = .left
        label.font = NSFont.systemFont(ofSize: 14)
        return label
    }()
    
    // 回放按钮
    lazy var replayButton: APPLabel = {
        let button = APPLabel()
        button.text = "精彩回放"
        button.wantsLayer = true
        button.layer?.backgroundColor = color_Theme1.cgColor
        button.textField.alignment = .center
        return button
    }()
    
    var model:HistoryCourseModel? {
        didSet {
            if let strongModel = model {
                courseNameLabel.stringValue = strongModel.courseName
                timeLabel.stringValue = strongModel.startTime+" - "+strongModel.endTime
                let image = NSImage(named: "Default_UserAvatar")
                pictureView.sd_setImage(with: URL(string: strongModel.avatarUrl),
                                            placeholderImage: image)
                nameLabel.stringValue = strongModel.nickName
                
                replayButton.layer?.backgroundColor = NSColor.lightGray.cgColor
                
                if strongModel.videoUrl.count>0 {
                    replayButton.layer?.backgroundColor = color_Theme1.cgColor
                }
                else {
                    replayButton.layer?.backgroundColor = NSColor.lightGray.cgColor
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
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.edges.equalTo(NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        view.addSubview(courseNameLabel)
        courseNameLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }

        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(courseNameLabel.snp.bottom)
            make.left.equalTo(courseNameLabel).offset(25)
            make.right.equalTo(courseNameLabel)
            make.height.equalTo(25)
        }
        
        let timeView = NSImageView(image: NSImage(named: "时钟")!)
        timeView.imageScaling = .scaleProportionallyUpOrDown
        view.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.left.equalTo(courseNameLabel)
            make.size.equalTo(CGSize(width: 18, height: 18))
        }
        
        view.addSubview(pictureView)
        pictureView.layer?.cornerRadius = 17.5
        pictureView.layer?.masksToBounds = true
        pictureView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 35, height: 35))
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.left.equalTo(courseNameLabel)
        }
        let label = NSTextField(wrappingLabelWithString: "授课")
        label.isSelectable = false
        label.textColor = .gray
        label.font = NSFont.systemFont(ofSize: 14)
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(pictureView)
            make.width.equalTo(view).multipliedBy(0.5)
            make.height.equalTo(pictureView).multipliedBy(0.5)
            make.left.equalTo(pictureView.snp.right).offset(10)
        }
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(pictureView)
            make.size.equalTo(label)
            make.left.equalTo(label)
        }
        
        view.addSubview(replayButton)
        replayButton.layer?.cornerRadius = 15
        replayButton.layer?.masksToBounds = true
        replayButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 30))
            make.right.equalTo(-25)
            make.bottom.equalTo(-25)
        }
    }
    
}
