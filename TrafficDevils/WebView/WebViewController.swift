//
//  WebViewController.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webViewTitle: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var goBackButton: BackButton!
    @IBOutlet weak var goForwardButton: StartButton!
    
    private var alertController: CustomAlertController?
    
    private var canGoBackObservation: NSKeyValueObservation?
    private var canGoForvardObservation: NSKeyValueObservation?
    private var titleObservation: NSKeyValueObservation?
    
    deinit {
            self.canGoBackObservation = nil
            self.canGoForvardObservation = nil
            self.titleObservation = nil
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "https://html5test.com") else { return}
        webView.layer.cornerRadius = 15
        webView.layer.borderWidth = 10
        webView.layer.borderColor = UIColor(red: 0.84, green: 0.45, blue: 0.11, alpha: 1.00).cgColor
        webView.layer.shadowColor = UIColor(red: 0.43, green: 0.17, blue: 0.01, alpha: 1.00).cgColor
        webView.layer.masksToBounds = true
        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        goBackButton.isEnabled = webView.canGoBack
        goForwardButton.isEnabled = webView.canGoForward
        canGoBackObservation = webView.observe(\WKWebView.title, options: .new) { _, change in
            self.webViewTitle.text = self.webView.title
        }
        canGoForvardObservation = webView.observe(\WKWebView.canGoBack, options: .new) { _, change in
            self.goBackButton.isEnabled = self.webView.canGoBack
        }
        titleObservation = webView.observe(\WKWebView.canGoForward, options: .new) { _, change in
            self.goForwardButton.isEnabled = self.webView.canGoForward
        }
        titleObservation = webView.observe(\WKWebView.canGoForward, options: .new) { _, change in
            self.goForwardButton.isEnabled = self.webView.canGoForward
        }
        self.webView.navigationDelegate = self
        self.alertController = CustomAlertController(vc: self)
    }
    
    override func viewDidLayoutSubviews() {
        let height = webViewTitle.bounds.height * 0.35
        self.webViewTitle.font = UIFont.systemFont(ofSize: height, weight: .heavy)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.alertController?.showErrorAlert(error: error)
    }
    
    @IBAction func backButtonAction(_ sender: BackButton) {
        self.goTo(vc: .main)
    }
    
    @IBAction func refreshButton(_ sender: CircleButton) {
        webView.reload()
    }
    
    @IBAction func webViewBackAction(_ sender: BackButton) {
        webView.goBack()
    }
    @IBAction func webViewForwardAction(_ sender: StartButton) {
        webView.goForward()
    }
}

extension WebViewController: CustomAlertDelegate {
    func cancelAction() {
        alertController?.dismissAlert(animated: true)
    }
    
    func okAction() {
        webView?.reload()
        alertController?.dismissAlert(animated: false)
    }
}
