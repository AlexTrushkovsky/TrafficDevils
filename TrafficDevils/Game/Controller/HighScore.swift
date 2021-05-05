//
//  HighScore.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import UIKit

class HighScore {
    let vc: UIViewController?
    
    init(vc: UIViewController) {
        self.vc = vc
    }
    
    func setHighScore(view: UIButton) {
        view.setTitle("\(value)", for: .normal)
    }
    
    func clearHighScore(view: UIButton) {
        UserDefaults.standard.setValue(0, forKeyPath: "highscore")
        setHighScore(view: view)
    }
    
    var value: Int {
        get {
            return UserDefaults.standard.integer(forKey: "highscore")
        }
    }
    
    func shareHighScore(sender: UIButton) {
        guard let baseImage = UIImage(named: "sharePic") else { return }
        let text = NSString(string: "\(value)")
        let image = textToImage(drawText: text, inImage: baseImage, atPoint: .init(x: 70, y: 80))
        let activityItem: [AnyObject] = [image as AnyObject]
        let activityViewController = UIActivityViewController(activityItems: activityItem, applicationActivities: nil)
        //for iPad
        if let presenter = activityViewController.popoverPresentationController {
            presenter.sourceView = sender
            presenter.sourceRect = sender.bounds
        }
        vc?.present(activityViewController, animated: true, completion: nil)
    }
    
    private func textToImage(drawText: NSString, inImage: UIImage, atPoint: CGPoint) -> UIImage{
        let textColor = UIColor(red: 0.86, green: 0.47, blue: 0.09, alpha: 1.00)
        let textFont = UIFont.systemFont(ofSize: 35, weight: .heavy)
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, scale)
        let myShadow = NSShadow()
        myShadow.shadowOffset = CGSize(width: 1, height: 1)
        myShadow.shadowColor = UIColor(red: 0.43, green: 0.17, blue: 0.01, alpha: 1.00)
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.shadow: myShadow
        ]
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        let rect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return inImage }
        UIGraphicsEndImageContext()
        return newImage
    }
}
