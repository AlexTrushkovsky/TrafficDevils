//
//  GameButton.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import UIKit

class GameButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.adjustsImageWhenDisabled = false
        self.backgroundColor = .clear
    }
}
