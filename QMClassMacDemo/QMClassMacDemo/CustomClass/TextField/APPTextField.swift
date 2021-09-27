//
//  APPTextField.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/22.
//

import Cocoa

class APPTextField: NSTextField {
    // 去除选中边框
    override func draw(_ dirtyRect: NSRect) {
        if window?.firstResponder == currentEditor() && NSApp.isActive {
            NSGraphicsContext.saveGraphicsState()
            NSFocusRingPlacement.only.set()
            NSGraphicsContext.restoreGraphicsState()
        } else {
            super.draw(dirtyRect)
        }
    }
}
