//
//  VideoWindowController.swift
//  QMClassMac
//
//  Created by penguin on 2021/8/5.
//

import Cocoa

@objc protocol VideoWindowControllerDelegate : NSObjectProtocol {
    /// 关闭回调
    @objc func VideoWindowControllerDidClose()
}

class VideoWindowController: NSWindowController {

    weak var delegate:VideoWindowControllerDelegate?
    
    var videoVC:VideoViewController? {
        get {
            return self.contentViewController as? VideoViewController
        }
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.delegate = self
        window?.styleMask = [.fullSizeContentView,.titled,.resizable,.miniaturizable,.closable]
        //隐藏titleBar透明
        window?.titlebarAppearsTransparent = true
        //隐藏title
        window?.titleVisibility = .hidden
        window?.title = ""
        //背景可以移动
        window?.isMovableByWindowBackground = true
        window?.isRestorable = false
        window?.center()
    }
}
extension VideoWindowController:NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        self.delegate?.VideoWindowControllerDidClose()
        return true
    }
    func windowWillEnterFullScreen(_ notification: Notification) {
        //print("将要进入全屏")
        self.videoVC?.windowWillEnterFullScreen(notification)
    }
    func windowDidEnterFullScreen(_ notification: Notification) {
        //print("已经进入全屏")
        self.videoVC?.windowDidEnterFullScreen(notification)
    }
    func windowWillExitFullScreen(_ notification: Notification) {
        //print("将要退出全屏")
        self.videoVC?.windowWillExitFullScreen(notification)
    }
    func windowDidExitFullScreen(_ notification: Notification) {
        //print("已经退出全屏")
        self.videoVC?.windowDidExitFullScreen(notification)
    }
}
