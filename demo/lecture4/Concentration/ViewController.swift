//
//  ViewController.swift
//  Concentration
//
//  Created by 张龙翔 on 2021/5/10.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    var flipCount: Int = 0 {
        didSet {
            updateFlipCountLabel()
            scoreLabel.text = "分数: \(game.score)"
            if(game.isFinishedGame) {
                finishGame()
                countLabel.text = "游戏结束"
            }
        }
    }
    
    func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : themeColorButton
        ]
        let attributedString = NSAttributedString(string: "次数: \(flipCount)", attributes: attributes)
        countLabel.attributedText = attributedString
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var countLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
            if(game.isFinishedGame) {
                finishGame()
                countLabel.text = "游戏结束"
            }
        }
    }
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        setup()
    }
    
    func finishGame() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
    private var theme: [[String]] = []
    private var themeColorButton: UIColor = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
    private var themeColorBackground: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    private var randomTheme: [String] = []
    private var animals: [String] = []
    private var sports: [String] = []
    private var faces: [String] = []
    private var cars: [String] = []
    private var flags: [String] = []
    private var foods: [String] = []
    
    func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : themeColorButton
            }
        }
    }
    
    func setColor(at theme: Int) {
        switch theme {
            case 0:
                themeColorButton = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
                themeColorBackground = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            case 1:
                themeColorButton = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
                themeColorBackground = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
            case 2:
                themeColorButton = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
                themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case 3:
                themeColorButton = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case 4:
                themeColorButton = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                themeColorBackground = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            case 5:
                themeColorButton = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                themeColorBackground = #colorLiteral(red: 0.4274509804, green: 0.737254902, blue: 0.3882352941, alpha: 1)
            default:
                themeColorButton = #colorLiteral(red: 0.9176470588, green: 0.662745098, blue: 0.2666666667, alpha: 1)
                themeColorBackground = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func getRamdomTheme() -> [String] {
        let index = theme.count.arc4Random
        setColor(at: index)
        return theme[index]
    }
    
    func setupTheme() {
        animals = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮"]
        sports = ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🥅", "🏒"]
        faces = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "😇", "🙂"]
        cars = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🚚", "🚛"]
        flags = ["🇹🇼", "🇯🇵", "🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇱🇷", "🎌", "🇨🇦", "🇳🇵", "🇬🇪"]
        foods = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑"]
        theme = [animals, sports, faces, cars, flags, foods]
        randomTheme = getRamdomTheme()
    }
    
//    var emojiChoices = ["🦢", "😈", "🐦", "🐷", "🐑", "🐂", "👨", "👩", "👦"]
    var emojiChoices = "🦢😈🐦🐷🐑🐂👨👩👦"
    
    var emoji = [Card:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    func setup(){
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        setupTheme()
        updateViewFromModel()
        view.backgroundColor = themeColorBackground
        for cardButton in cardButtons {
            cardButton.backgroundColor = themeColorButton
        }
        scoreLabel.textColor = themeColorButton
        countLabel.textColor = themeColorButton
        newGameButton.setTitleColor(themeColorBackground, for: .normal)
        newGameButton.backgroundColor = themeColorButton
        flipCount = 0
        game.score = 0
        game.isFinishedGame = false
        updateFlipCountLabel()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
}

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32((self))))
        } else {
            return 0
        }
    }
}
