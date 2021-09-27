//
//  NSAlert+Extension.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/24.
//

import Foundation
import AppKit

extension NSAlert {
    class func showInfo(window:NSWindow?,
                    title:String,
                    content:String) {
        if let strongWindow = window {
            let alert = NSAlert()
            alert.messageText = title
            alert.informativeText = content
            alert.alertStyle = .informational
            alert.addButton(withTitle: "确定")
            alert.beginSheetModal(for: strongWindow) { response in
                print(response.rawValue)
            }
        }
        

    }
    class func showCritical(window:NSWindow?,
                    title:String,
                    content:String) {
        if let strongWindow = window {
            let alert = NSAlert()
            alert.messageText = title
            alert.informativeText = content
            alert.alertStyle = .critical
            alert.addButton(withTitle: "确定")
            alert.beginSheetModal(for: strongWindow) { response in
                print(response.rawValue)
            }
        }
    }
}
