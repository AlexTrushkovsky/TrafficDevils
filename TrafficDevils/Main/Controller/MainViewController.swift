//
//  ViewController.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var getRequestButton: UIButton!
    @IBOutlet weak var webVIewButton: UIButton!
    @IBOutlet weak var highScoreButton: HighScoreButton!
    
    private var highScore: HighScore?
    private var alertController: CustomAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.highScore = HighScore(vc: self)
        self.alertController = CustomAlertController(vc: self)
        highScore?.setHighScore(view: highScoreButton)
    }

    @IBAction func startGame(_ sender: UIButton) {
        self.goTo(vc: .game)
    }
    
    @IBAction func getRequest(_ sender: UIButton) {
        self.goTo(vc: .getRequest)
    }
    
    @IBAction func webView(_ sender: UIButton) {
        self.goTo(vc: .web)
    }
    
    @IBAction func shareHighScore(_ sender: ShareButton) {
        highScore?.shareHighScore(sender: sender)
    }
    @IBAction func highScoreInfoButton(_ sender: HighScoreButton) {
        alertController?.showAlert(with: "Are you sure you want to reset the highscore?")
    }
    
}

extension MainViewController: CustomAlertDelegate {
    func cancelAction() {
        alertController?.dismissAlert(animated: true)
    }
    
    func okAction() {
        highScore?.setHighScore(view: highScoreButton)
        alertController?.dismissAlert(animated: false)
    }
}
