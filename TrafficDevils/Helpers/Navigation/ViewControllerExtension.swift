//
//  ViewControllerExtension.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit

extension UIViewController {
    func goTo(vc: ViewControllers) {
        let vc = UIStoryboard(name: vc.rawValue, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
}

enum ViewControllers: String {
    case main = "Main"
    case game = "GameView"
    case web = "WebView"
    case getRequest = "GetRequestView"
}
