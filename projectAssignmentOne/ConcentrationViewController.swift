//
//  ViewController.swift
//  projectAssignmentOne
//
//  Created by Nikita Skrypchenko  on 11/25/18.
//  Copyright © 2018 Nikita Skrypchenko . All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    private lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(game.score)"
        }
    }
    
    var username:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(username)
        indexTheme =  Int.random(in: 0..<emojiThemes.count)
        updateViewFromModel()
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var themeName: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print(  )
        }
        else {
            print ("something wrong")
        }
        
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                 button.backgroundColor = UIColor.white
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColor
                
            }
        }
        
        scoreLabel.text = "Score: \(game.score)"
        
    }
    
    
    private struct Theme {
        var name: String
        var emojis: [String]
        var viewColor: UIColor
        var cardColor: UIColor
    }
    
    private var emojiThemes: [Theme] = [
        Theme(
            name: "Fruits",
            emojis: ["🍎", "🍌", "🍏", "🍐", "🍊", "🍋", "🍉","🍇", "🍓", "🍈", "🍒", "🍑", "🍍"],
            viewColor: #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1),
            cardColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        ),
        Theme(
            name: "Faces",
            emojis: ["😀", "😃", "🤣", "😘", "😠", "🤓", "🤪","😇","🤮"],
            viewColor: #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1),
            cardColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        ),
        Theme(
            name: "Activity",
            emojis: ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅"],
            viewColor: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1),
            cardColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        ),
        Theme(
            name: "Travel",
            emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🚔", "✈️"],
            viewColor: #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1),
            cardColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        ),
        Theme(
            name: "Christmas",
            emojis: ["❄️", "☃️", "🎿", "🤶🏼", "🎄", "🎅🏼", "🎁", ],
            viewColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1),
            cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        ),
        Theme(
            name: "Flags",
            emojis: ["🏳️‍🌈", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇮🇴", "🇻🇬", "🇨🇲","🇨🇱", "🇨🇩", "🇨🇮", "🇩🇴","🇪🇨","🇨🇮", "🇺🇦", "🇱🇨", "🇺🇸", "🇪🇸"],
            viewColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),
            cardColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        )
    ]
    
    lazy var emojiChoices: [String] = emojiThemes[2].emojis
    private var backgroundColor = UIColor.black
    private var cardColor = UIColor.orange
    
    private var indexTheme = 0 {
        didSet{
            themeName.text = emojiThemes[indexTheme].name
            emojiChoices = emojiThemes[indexTheme].emojis
            emoji = [Card: String]()
            backgroundColor = emojiThemes[indexTheme].viewColor
            cardColor = emojiThemes[indexTheme].cardColor
            updateAppereance()
            
        }
    }
    
    func updateAppereance(){
        view.backgroundColor = backgroundColor
        themeName.textColor = cardColor
        scoreLabel.textColor = cardColor
        newGameButton.setTitleColor(backgroundColor, for: .normal)
        newGameButton.backgroundColor = cardColor
        
    }
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            
            emoji[card] = emojiChoices.remove(at: Int.random(in: 0..<emojiChoices.count))
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction func newGame() {
        indexTheme = Int.random(in: 0..<emojiThemes.count)
        score = 0
        game.resetGame()
    }
    
}
