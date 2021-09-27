//
//  NSColor+Extension.swift
//  QMClassMac
//
//  Created by penguin on 2021/6/18.
//

import Foundation
import AppKit

//MARK: 基础颜色
let color_black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
let color_white = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
let color_gray = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
let color_red = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
let color_orange = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
let color_blue = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
let color_green = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
let color_blue2 = #colorLiteral(red: 0.2784313725, green: 0.3921568627, blue: 0.8156862745, alpha: 1)
let color_blue3 = #colorLiteral(red: 0.1844414771, green: 0.6659726501, blue: 0.9280208945, alpha: 1)
let color_blue4 = #colorLiteral(red: 0.1544730067, green: 0.4423713684, blue: 0.6749771237, alpha: 1)
let color_blue5 = #colorLiteral(red: 0.2246459126, green: 0.7731027007, blue: 0.9982408881, alpha: 1)

let color_orange2 = #colorLiteral(red: 1, green: 0.7764705882, blue: 0, alpha: 1)
// 直播节目深黑色
let color_black2 = #colorLiteral(red: 0.1488672197, green: 0.1528193057, blue: 0.1611176431, alpha: 1)
// 直播节目浅黑色
let color_black3 = #colorLiteral(red: 0.2701669335, green: 0.2820392847, blue: 0.3028204739, alpha: 1)
// 直播节目菜单透明黑
let color_black4 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)

let color_black5 = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)

let color_red2 = #colorLiteral(red: 1, green: 0.4156862745, blue: 0.4156862745, alpha: 1)

let color_gray2 = #colorLiteral(red: 0.9605508447, green: 0.9646353126, blue: 0.9727998376, alpha: 1)
let color_gray3 = #colorLiteral(red: 0.6037368178, green: 0.6078248024, blue: 0.6118959785, alpha: 1)

let color_green2 = #colorLiteral(red: 0.8126372695, green: 0.9225896001, blue: 0.8899760842, alpha: 1)

let color_white2 = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)

let color_Theme1 = #colorLiteral(red: 0.1532616615, green: 0.6976590753, blue: 0.5465596318, alpha: 1)

/// 主题色
let QMColor_Theme = #colorLiteral(red: 0.1532616615, green: 0.6976590753, blue: 0.5465596318, alpha: 1)
/// 纯黑
let QMColor_black = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
/// 暗黑（白板底色、）
let QMColor_black2 = #colorLiteral(red: 0.09735731035, green: 0.1172493473, blue: 0.1422172785, alpha: 1)
/// 浅暗黑（左侧工具条、底部工具条）
let QMColor_black3 = #colorLiteral(red: 0.1490196078, green: 0.1725490196, blue: 0.1960784314, alpha: 1)
/// 浅黑（高亮选择、聊天文本框）
let QMColor_black4 = #colorLiteral(red: 0.2345150709, green: 0.2584708929, blue: 0.2834717035, alpha: 1)
/// 分隔线
let QMColor_line = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
/// 字体颜色
let QMColor_Text = #colorLiteral(red: 0.8626509309, green: 0.8627994061, blue: 0.8626416326, alpha: 1)
/// 白色半透明遮罩
let QMColor_Cover = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3)


extension NSColor {
    //MARK: 随机颜色
    /// 随机颜色
    ///
    /// - Returns: 颜色
    class func color_Random() -> (NSColor) {
        return NSColor.init(red: CGFloat(arc4random()%255)/255.0,
                            green: CGFloat(arc4random()%255)/255.0,
                            blue: CGFloat(arc4random()%255)/255.0,
                            alpha: 1)
    }
}
