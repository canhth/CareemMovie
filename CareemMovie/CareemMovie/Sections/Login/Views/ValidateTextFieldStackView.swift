//
//  ValidateTextFieldStackView.swift
//  ListingRestaurant
//
//  Created by Tran Hoang Canh on 28/2/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit

class ValidateTextFieldStackView: UIStackView {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        inputTextField.attributedPlaceholder = NSAttributedString(string: self.inputTextField.placeholder ?? "",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func setupErrorMessageView(isHidden hidden: Bool, errorMessage: String) {
        UIView.animate(withDuration: 0.3) {
           
            self.errorLabel.text = errorMessage
            
            //The bug is that hiding and showing views in a stack view is cumulative. Weird Apple bug. If you hide a view in a stack view twice, you need to show it twice to get it back. If you show it three times, you need to hide it three times to actually hide it (assuming it was hidden to start).
            if !hidden {
                if self.errorLabel.isHidden == true {
                    self.errorLabel.isHidden = false
                }
            } else {
                if self.errorLabel.isHidden == false {
                    self.errorLabel.isHidden = true
                }
            }
            self.layoutIfNeeded()
        }
    }

}
