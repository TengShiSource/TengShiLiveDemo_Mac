//
//  NSButton+Extension.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/21.
//

import Foundation
import AppKit

extension NSButton {
    
    func attributedTitle(text:String,
                         color:NSColor) {
        self.attributedTitle = NSAttributedString(string: text,
                                                  attributes: [NSAttributedString.Key.foregroundColor : color])
    }

    func attributedTitle(text:String,
                           color:NSColor,
                           font:NSFont) {
        self.attributedTitle = NSAttributedString(string: text,
                                                  attributes: [NSAttributedString.Key.foregroundColor : color,
                                                               NSAttributedString.Key.font : font])
    }
}
