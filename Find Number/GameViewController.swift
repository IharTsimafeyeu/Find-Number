//
//  GameViewController.swift
//  Find Number
//
//  Created by Игорь Тимофеев on 5.11.21.
//

import UIKit

final class GameViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nextDigit: UILabel!
    lazy var game = Game(countItems: buttons.count)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        
        updateUI()
        
        
    }
    
    private func setupScreen(){ // тут настраиваем экран
        
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
            buttons[index].isHidden = false
        }
        
        nextDigit.text = game.nextItem?.title
    }
    func updateUI() {
        for index in game.items.indices {
            buttons[index].isHidden = game.items[index].isFound
        }
        nextDigit.text = game.nextItem?.title
        
        if game.status == .win {
            statusLabel.text = "Вы выиграли"
            statusLabel.textColor = .green
        }
    }
}
