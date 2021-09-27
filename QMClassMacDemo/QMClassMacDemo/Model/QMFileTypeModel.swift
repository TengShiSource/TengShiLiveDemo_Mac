//
//  QMFileTypeModel.swift
//  QMClassMac
//
//  Created by penguin on 2021/7/27.
//

import Foundation

class QMFileTypeModel {
    /// 文件展示名称
    var fileName:String = ""
    /// 类型id
    var fileID:String = ""
    
    init(fileName:String, fileID:String) {
        self.fileName = fileName
        self.fileID = fileID
    }
}
