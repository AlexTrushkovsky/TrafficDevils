//
//  CustomAlert.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 04.05.2021.
//

import UIKit

class CustomAlertController {
    let vc: UIViewController?
    
    init(vc: UIViewController) {
        self.vc = vc
        setupVisualEffectView()
    }
    
    private lazy var alertView: CustomAlert = {
        let alertView: CustomAlert = CustomAlert.loadFromNib()
        alertView.delegate = vc as? CustomAlertDelegate
        return alertView
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func showAlert(with text: String) {
        setAlert()
        self.alertView.setText(title: text)
        animateIn()
    }
    
    func dismissAlert(animated: Bool) {
        animateOut(animated: animated)
    }
    
    func showErrorAlert(error: Error?) {
        let text = error?.localizedDescription ?? "Unknown error happened."
        showAlert(with: text + " Do you want to reload the page?")
    }
    
    private func setAlert() {
        guard let view = vc?.view else { return }
        alertView = CustomAlert.loadFromNib()
        alertView.delegate = vc as? CustomAlertDelegate
        view.addSubview(alertView)
        alertView.center = view.center
    }
    
    private func animateIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
            
        }
    }
    
    private func animateOut(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.visualEffectView.alpha = 0
                self.alertView.alpha = 0
                self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            }) { (_) in
                self.alertView.removeFromSuperview()
            }
        } else {
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.alertView.removeFromSuperview()
        }
    }
    
    private func setupVisualEffectView() {
        guard let view = vc?.view else { return }
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
}
