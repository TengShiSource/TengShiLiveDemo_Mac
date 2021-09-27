//
//  AvatarListItem.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/23.
//

import Cocoa

class AvatarListItem: NSCollectionViewItem {
    
    var imageUrl:String? {
        didSet {
            if let url = imageUrl {
//                pictureView.sd_setImage(with: URL(string: url),
//                                            placeholderImage: NSImage(named: "Default_UserAvatar"))
                pictureView.sd_setImage(with: URL(string: url),
                                        placeholderImage: NSImage(named: "Default_UserAvatar"),
                                        options: .retryFailed,
                                        completed: nil)
            }
        }
    }
    
    // 底部图片
    lazy var pictureView: NSImageView = {
        let view = NSImageView()
        view.image = NSImage(named: "BoardIcon_Download")
        view.imageFrameStyle = .none
        view.imageAlignment = .alignCenter
        view.imageScaling = .scaleAxesIndependently
        return view
    }()
    
    override func loadView() {
        self.view = NSView()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(pictureView)
        pictureView.snp.makeConstraints { make in
            make.edges.equalTo(NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
    }
    
}
