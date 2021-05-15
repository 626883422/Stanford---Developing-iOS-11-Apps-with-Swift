//
//  ViewController.swift
//  Set
//
//  Created by 张龙翔 on 2021/5/15.
//

import UIKit

class ViewController: UIViewController {

    private var engine = SetEngine()
    private var selectedButton = [UIButton]()
    private var hintedButton = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }

    @IBOutlet var cardsButton: [UIButton]!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var moreThreeButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func cardsButtonPressed(_ sender: UIButton) {
        if let cardIndex = cardsButton.index(of: sender) {
            if cardIndex < engine.cardOnTable.count {
                engine.chooseCard(at: cardIndex)
                chooseButton(at: sender)
                updateViewFromModel()
            } else {
                print("chosen card was not in cardButtons")
            }
            print(selectedButton.count)
        }
    }
    
    @IBAction func moreThreeButtonPressed(_ sender: UIButton) {
        if selectedButton.count == 3 {
            
        }
        engine.draw()
        updateViewFromModel()
        hiddenButtonIfNeed()
    }
    
    @IBAction func hintButtonPressed(_ sender: UIButton) {
        engine.hint()
        if engine.hintCard.count > 0 {
            for hint in 0...2 {
                let index = engine.hintCard[hint]
                cardsButton[index].layer.borderColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                cardsButton[index].layer.borderWidth = 3.0
                hintedButton.append(cardsButton[index])
            }
            hintedButton.removeAll()
        }
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        engine = SetEngine()
        resetButton()
        updateViewFromModel()
        hiddenButtonIfNeed()
        updateScore()
        selectedButton.removeAll()
        hintedButton.removeAll()
    }
    
    
    private func chooseButton(at card: UIButton) {
        if selectedButton.contains(card) {
            card.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            card.layer.borderWidth = 3.0
            selectedButton.remove(at: selectedButton.firstIndex(of: card)!)
            return
        } else if selectedButton.count == 3 {
            cardsButton.forEach() {
                $0.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
            selectedButton.removeAll()
            updateScore()
        }
        selectedButton += [card]
        card.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        card.layer.borderWidth = 3.0
    }
    
    private func updateScore() {
        scoreLabel.text = "\(engine.score)"
    }
    
    private func updateViewFromModel() {
        for index in engine.cardOnTable.indices {
            cardsButton[index].titleLabel?.numberOfLines = 0
            cardsButton[index].setAttributedTitle(setCardTitle(with: engine.cardOnTable[index]), for: .normal)
        }
    }
    
    private func setCardTitle(with card: Card) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: ModelToView.colors[card.color]!,
            .strokeWidth: ModelToView.strokeWidth[card.fill]!,
            .foregroundColor: ModelToView.colors[card.color]!.withAlphaComponent(ModelToView.alpha[card.fill]!)
        ]
        var cardTitle = ModelToView.shapes[card.shape]!
        switch card.number {
        case .two:
            cardTitle = "\(cardTitle)\n\(cardTitle)"
        case .three:
            cardTitle = "\(cardTitle)\n\(cardTitle)\n\(cardTitle)"
        default:
            break
        }
        return NSAttributedString(string: cardTitle, attributes: attributes)
    }
    
    private func hiddenButtonIfNeed() {
        if engine.cardOnTable.count == 24 || engine.numberOfCard == 0 {
            moreThreeButton.isHidden = true
        } else {
            moreThreeButton.isHidden = false
        }
    }
    
    private func resetButton() {
        for button in cardsButton {
            let nsAttributedString = NSAttributedString(string: "")
            button.setAttributedTitle(nsAttributedString, for: .normal)
            button.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        }
    }
    
}

struct ModelToView {
    static let shapes: [Card.Shape: String] = [.circle: "●", .triangle: "▲", .square: "■"]
    static var colors: [Card.Color: UIColor] = [.red: #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), .green: #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), .purple: #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)]
    static var alpha: [Card.Fill: CGFloat] = [.solid: 1.0, .empty: 0.4, .stripe: 0.15]
    static var strokeWidth: [Card.Fill: CGFloat] = [.solid: -5, .empty: 5, .stripe: -5]
}
