//
//  CustomAlert.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import UIKit

protocol CustomAlertDelegate {
    func cancelAction()
    func okAction()
}

class CustomAlert: UIView {
    var delegate: CustomAlertDelegate?
    @IBOutlet weak var negativeButton: SquareButton!
    @IBOutlet weak var positiveButton: SquareButton!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func negativeButtonAction(_ sender: SquareButton) {
        delegate?.cancelAction()
        
    }
    @IBAction func positiveButtonAction(_ sender: SquareButton) {
        delegate?.okAction()
        
    }
    
    func setText(title: String) {
        label.text = title
    }
    
}

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
