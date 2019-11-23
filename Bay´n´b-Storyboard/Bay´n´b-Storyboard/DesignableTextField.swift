//
//  DesignableTextField.swift
//  Bay´n´b-Storyboard
//
//  Created by Sebastian Nikles on 23.11.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    var showCursor = true
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }

    @IBInspectable var leftPadding: CGFloat = 0

    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return showCursor ? super.caretRect(for: position) : CGRect.zero
    }

    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
            leftView?.addSubview(imageView)
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }

        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    func addUnderline() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: bounds.height + 2, width: bounds.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 165.0/255, green: 194.0/255, blue: 211.0/255, alpha: 1.0).cgColor
        layer.addSublayer(bottomLine)
    }
}
