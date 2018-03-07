//
//  UITextField+Extension.swift
//  ListingRestaurant
//
//  Created by Canh Tran on 2/27/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit

@IBDesignable
extension UITextField {
    
    @IBInspectable var localizeKey: String {
        
        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }
    
    @IBInspectable var placeholderLocalizeKey: String {
        
        get {
            return ""
        } set {
            self.placeholder = NSLocalizedString(newValue, comment: "")
        }
    }
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
