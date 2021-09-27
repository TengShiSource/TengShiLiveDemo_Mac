//
//  LoginWindowController.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/18.
//

import Cocoa

class LoginWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        window?.delegate = self
        window?.styleMask = [.titled,.miniaturizable,.closable]
        //隐藏titleBar透明
        window?.titlebarAppearsTransparent = false
        //隐藏title
        window?.titleVisibility = .hidden
        window?.title = ""
        //背景白色
        window?.backgroundColor = .white
        //隐藏miniaturize按钮
        window?.standardWindowButton(.miniaturizeButton)?.isHidden = true
        //隐藏zoom按钮
        window?.standardWindowButton(.zoomButton)?.isHidden = true
        //背景可以移动
        window?.isMovableByWindowBackground = true
        window?.isRestorable = false
        window?.center()
    }
}

extension LoginWindowController:NSWindowDelegate {
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.hide(nil)
        return false
    }
//    func windowWillClose(_ notification: Notification) {
//        exit(0)
//    }
}
