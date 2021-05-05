//
//  WoodenButtons.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit

class SquareButton: WoodenButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setBackgroundImage(UIImage(named: "squareButton"), for: .normal)
        let pressedImage = UIImage(named: "squareButtonPressed")
        self.disabledImage = pressedImage
        self.highlightedImage = pressedImage
        self.selectedImage = pressedImage
    }
}

class CircleButton: WoodenButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setBackgroundImage(UIImage(named: "circleButton"), for: .normal)
        let pressedImage = UIImage(named: "circleButtonPressed")
        self.disabledImage = pressedImage
        self.highlightedImage = pressedImage
        self.selectedImage = pressedImage
    }
}

class ShareButton: WoodenButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setBackgroundImage(UIImage(named: "shareButton"), for: .normal)
        let pressedImage = UIImage(named: "shareButtonPressed")
        self.disabledImage = pressedImage
        self.highlightedImage = pressedImage
        self.selectedImage = pressedImage
    }
}

class StartButton: WoodenButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setBackgroundImage(UIImage(named: "startButton"), for: .normal)
        let pressedImage = UIImage(named: "startButtonPressed")
        self.disabledImage = pressedImage
        self.highlightedImage = pressedImage
        self.selectedImage = pressedImage
    }
}

class BackButton: StartButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double(-180) * .pi/180))
    }
}

class WoodenButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.alpha = 1
        let height = self.bounds.height * 0.3
        imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: (imageView?.frame.width)!)
        self.setTitleColor(UIColor(red: 0.40, green: 0.19, blue: 0.05, alpha: 1.00), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: height, weight: .heavy)
        self.titleLabel?.textColor = UIColor(red: 0.40, green: 0.19, blue: 0.05, alpha: 1.00)
    }
}

class HighScoreButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.alpha = 1
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
        let height = self.bounds.height * 0.5
        let margin = self.bounds.height * 1.1
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: 0)
        self.setTitleColor(UIColor(red: 0.40, green: 0.19, blue: 0.05, alpha: 1.00), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: height, weight: .heavy)
        self.titleLabel?.textColor = UIColor(red: 0.40, green: 0.19, blue: 0.05, alpha: 1.00)
        
        self.setBackgroundImage(UIImage(named: "highScore"), for: .normal)
        let pressedImage = UIImage(named: "highScorePressed")
        self.disabledImage = pressedImage
        self.highlightedImage = pressedImage
        self.selectedImage = pressedImage
    }
}

var disabledImageHandle: UInt8 = 0
var highlightedImageHandle: UInt8 = 0
var selectedImageHandle: UInt8 = 0

extension UIButton {
    @IBInspectable
    var disabledImage: UIImage? {
        get {
            if let image = objc_getAssociatedObject(self, &disabledImageHandle) as? UIImage {
                return image
            }
            return nil
        }
        set {
            if let image = newValue {
                self.setBackgroundImage(image, for: .disabled)
                objc_setAssociatedObject(self, &disabledImageHandle, image, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    var highlightedImage: UIImage? {
        get {
            if let image = objc_getAssociatedObject(self, &highlightedImageHandle) as? UIImage {
                return image
            }
            return nil
        }
        set {
            if let image = newValue {
                self.setBackgroundImage(image, for: .highlighted)
                objc_setAssociatedObject(self, &highlightedImageHandle, image, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @IBInspectable
    var selectedImage: UIImage? {
        get {
            if let image = objc_getAssociatedObject(self, &selectedImageHandle) as? UIImage {
                return image
            }
            return nil
        }
        set {
            if let image = newValue {
                self.setBackgroundImage(image, for: .selected)
                objc_setAssociatedObject(self, &selectedImageHandle, image, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
