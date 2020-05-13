//
//  ViewController.swift
//  Concentration
//
//  Created by Ivanych Puy on 02.05.2020.
//  Copyright © 2020 xubuntus. All rights reserved.
//
//74
import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return cardButtons.count / 2
    }

    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    @IBAction private func resetGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        emojiTheme = nil
        viewDidLoad()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            flipCountLabel.text = "Flips:\(game.flipCount)"
            scoreLabel.text = "Score:\(game.score)"
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : emojiTheme.backgroundColor
            }
        }
    }
    
    typealias emojiType = (name: String, emojiString: String, backColor: UIColor, backgroundColor: UIColor)
    
    private var emojiTheme: emojiType!
    
//    private var emojiChoices: [emojiType] = [
//        ("fruits", ["🍏", "🍌", "🍍", "🥥", "🥝", "🍇"], #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
//        ("sports", ["⚽️", "🏀", "⛸", "🎱", "🥊", "🏇"], #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)),
//        ("activities", ["🎠", "⛱", "🏕", "🗿", "🗽", "⛰"], #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
//    ]
     private var emojiChoices: [emojiType] = [
            ("fruits", "🍏🍌🍍🥥🥝🍇", #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
            ("sports", "⚽️🏀⛸🎱🥊🏇", #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)),
            ("activities", "🎠⛱🏕🗿🗽⛰", #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
        ]
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiTheme.emojiString.count > 0 {
            let randomStringIndex = emojiTheme.emojiString.index(emojiTheme.emojiString.startIndex, offsetBy: Int.random(in: 0..<emojiTheme.emojiString.count))
            emoji[card] = String(emojiTheme.emojiString.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    override func viewDidLoad() {
        emojiTheme = emojiChoices[Int(arc4random_uniform(UInt32(emojiChoices.count)))]
        self.view.backgroundColor = emojiTheme.backColor
        for cardButton in cardButtons {
            cardButton.backgroundColor = emojiTheme.backgroundColor
        }
    }
}

