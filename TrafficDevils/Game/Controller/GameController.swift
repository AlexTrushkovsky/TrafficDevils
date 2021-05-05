//
//  GameController.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit
import AVFoundation

class GameController: UIViewController {
    
    private lazy var game = Game(numPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .light)
    private let positiveSound = URL(fileURLWithPath: Bundle.main.path(forResource: "positiveSound", ofType: "mp3")!)
    private let errorSound = URL(fileURLWithPath: Bundle.main.path(forResource: "negativeSound", ofType: "mp3")!)
    
    private var soundEffectsPlayer: AVAudioPlayer = {
        var audioPlayer = AVAudioPlayer()
        audioPlayer.setVolume(0.8, fadeDuration: 0)
        return audioPlayer
    }()
    
    private var musicPlayer = AVAudioPlayer()
    private var lastTouchedCardIndex: Int? = nil
    private var image = [Card: String]()
    private var cardImages: [String]?
    private var highScore: HighScore?
    private var alertController: CustomAlertController?
    private var isEnd = false
    
    @IBOutlet private weak var highScoreButton: HighScoreButton!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private(set) var cardButtons: [UIButton]!
    @IBOutlet private weak var newGameButton: UIButton!
    @IBOutlet private weak var BackButton: UIButton!
    
    
    @IBAction func shareButtonAction(_ sender: ShareButton) {
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        highScore?.shareHighScore(sender: sender)
    }
    
    @IBAction func highScoreInfoButton(_ sender: HighScoreButton) {
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        alertController?.showAlert(with: "Are you sure you want to reset the highscore?")
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        self.goTo(vc: .main)
    }
    
    @IBAction private func touchNewGameButton(_ sender: UIButton) {
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
        newGame()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        } else {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            lastTouchedCardIndex = cardNumber
            game.chooseCard(at: cardNumber)
            
            if game.correctMatch == Match.yes {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.playSound(sound: self.positiveSound)
                })
            } else if game.correctMatch == Match.no {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.playSound(sound: self.errorSound)
                })
            }
            
            updateViewFromModel()
            
        } else {
            print("Chosen card was not in card buttons set")
        }
        
        if game.gameOver {
            createShavings(view: self.view)
            endGame()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.highScore = HighScore(vc: self)
        self.alertController = CustomAlertController(vc: self)
        self.highScore?.setHighScore(view: highScoreButton)
        self.cardImages = CardImages.images
        updateViewFromModel()
    }
    
    override func viewDidLayoutSubviews() {
        let height = scoreLabel.bounds.height / 2
        self.scoreLabel.font = UIFont.systemFont(ofSize: height, weight: .heavy)
    }
    
    private func newGame() {
        setActionForEndOfGame(isEnd: false)
        lastTouchedCardIndex = nil
        view.removeLayer(layerName: "shavings")
        game.newGame()
        image.removeAll()
        self.cardImages = CardImages.images
        updateViewFromModel()
    }
    
    private func endGame() {
        highScore?.setHighScore(view: highScoreButton)
        setActionForEndOfGame(isEnd: true)
        let text = game.score == game.highScore ? "🎉  \(game.score)  🎉" : "\(game.score)"
        alertController?.showAlert(with: text + "\n Start new game?")
    }
    
    private func setActionForEndOfGame(isEnd: Bool) {
        self.isEnd = isEnd
    }
    
    private func updateViewFromModel() {
        scoreLabel.text = "\(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setBackgroundImage(UIImage(named: image(for: card)), for: .normal)
                button.isEnabled = false
            } else {
                if card.isMatched {
                    UIView.animate(withDuration: 0.3) { button.alpha = 0.5 }
                    button.isEnabled = false
                } else {
                    button.alpha = 1
                    button.setBackgroundImage(UIImage(named: "back"), for: .normal)
                    button.isEnabled = true
                }
            }
        }
        if let index = lastTouchedCardIndex {
            UIView.transition(with: cardButtons[index], duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    private func image(for card: Card) -> String {
        if image[card] == nil && cardImages != nil {
            image[card] = cardImages!.remove(at: cardImages!.count.arc4random)
        }
        return image[card] ?? "back"
    }
    
    private func playSound(sound: URL) {
        do {
            soundEffectsPlayer = try AVAudioPlayer(contentsOf: sound)
            soundEffectsPlayer.play()
        } catch let error {
            print("playSound error: \(error)")
        }
    }
}

// MARK: Extensions
extension GameController: CustomAlertDelegate {
    func cancelAction() {
        if self.isEnd {
            self.goTo(vc: .main)
        }
        alertController?.dismissAlert(animated: true)
    }
    
    func okAction() {
        if self.isEnd {
            self.newGame()
            alertController?.dismissAlert(animated: true)
        } else {
            highScore?.clearHighScore(view: highScoreButton)
        }
        alertController?.dismissAlert(animated: true)
    }
}

