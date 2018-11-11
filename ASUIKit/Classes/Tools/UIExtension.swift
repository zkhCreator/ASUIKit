//
//  UIExtension.swift
//  ASTool
//
//  Created by 章凯华 on 2018/10/6.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(asHex: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red = CGFloat((asHex & 0xF00) >> 8) / divisor
        let green = CGFloat((asHex & 0x0F0) >> 4) / divisor
        let blue = CGFloat(asHex & 0x00F) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIViewController {
    func show(newViewController:UIViewController, animated:Bool) {
        if self.navigationController != nil {
            self.navigationController?.pushViewController(newViewController, animated: animated)
        } else {
            self.present(newViewController, animated: animated, completion: nil)
        }
    }
}
