//
//  Extentions.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 05.05.2021.
//

import UIKit

extension UIView {
    func removeLayer(layerName: String) {
        for item in self.layer.sublayers ?? [] where item.name == layerName {
            item.removeFromSuperlayer()
        }
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true}
        if let leading = leading {leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true}
        if let bottom = bottom {bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true}
        if let trailing = trailing {trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true}
        if size.width != 0 {widthAnchor.constraint(equalToConstant: size.width).isActive = true}
        if size.height != 0 {heightAnchor.constraint(equalToConstant: size.height).isActive = true}
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

func createShavings(view: UIView) {
    let particleEmitter = CAEmitterLayer()
    particleEmitter.name = "shavings"
    particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
    particleEmitter.emitterShape = CAEmitterLayerEmitterShape.line
    particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
    particleEmitter.emitterCells = generateEmitterCells()
    view.layer.addSublayer(particleEmitter)
}

func generateEmitterCells() -> [CAEmitterCell] {
    var cells:[CAEmitterCell] = [CAEmitterCell]()
    for i in 0...15 {
        let cell = CAEmitterCell()
        cell.birthRate = 4.0
        cell.lifetime = 14.0
        cell.lifetimeRange = 0
        cell.velocity = CGFloat(Shavings.velocities.randomElement() ?? 100)
        cell.velocityRange = 0
        cell.emissionLongitude = CGFloat(Double.pi)
        cell.emissionRange = 0.5
        cell.spin = 3.5
        cell.spinRange = 0
        cell.scaleRange = 0.25
        cell.scale = 0.1
        cell.contents = Shavings.images[i % 4].cgImage
        cells.append(cell)
    }
    return cells
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
