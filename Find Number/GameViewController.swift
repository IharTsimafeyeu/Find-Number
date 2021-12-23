import UIKit

final class GameViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextDigit: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    lazy var game = Game(countItems: buttons.count, time: 30) { [weak self](status, time) in
        guard let self = self else {return}
        self.timerLabel.text = time.secondsToString()
        self.updateInfoGame(with: status)
    }
    
    
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }

}

//MARK: Functions
extension GameViewController {
    @IBAction func pressButton(_ sender: UIButton) {
        guard let buttonIndex = buttons.firstIndex(of: sender) else { return }
        game.check(index: buttonIndex)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        sender.isHidden = true
        setupScreen()
    }
    
    private func setupScreen(){ // тут настраиваем экран
        
        for index in game.items.indices {
            buttons[index].setTitle(game.items[index].title, for: .normal)
//            buttons[index].isHidden = false
            buttons[index].alpha = 1
            buttons[index].isEnabled = true
        }
        nextDigit.text = game.nextItem?.title
    }
    func updateUI() {
        for index in game.items.indices {
//            buttons[index].isHidden = game.items[index].isFound
            buttons[index].alpha = game.items[index].isFound ? 0 : 1
            buttons[index].isEnabled = !game.items[index].isFound
            
            if game.items[index].isError {
                UIView.animate(withDuration: 0.3) { [weak self] in
                    self?.buttons[index].backgroundColor = .red
                } completion: { [weak self](_) in
                    self?.buttons[index].backgroundColor = .white
                    self?.game.items[index].isError = false
                }
            }
        }
        nextDigit.text = game.nextItem?.title
        
        updateInfoGame(with: game.status)
    }
    
    private func updateInfoGame(with status: StatusGame) {
        switch status {
        case .start:
            statusLabel.text = "Игра началась"
            statusLabel.textColor = .black
            newGameButton.isHidden = true
        case .win:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        case .lose:
            statusLabel.text = "Вы проиграли"
            statusLabel.textColor = .red
            newGameButton.isHidden = false
        }
    }
}

extension Int {
    func secondsToString() -> String {
        let minutes = self / 60
        let seconds = self % 60
        
        return String(format: "%d:%02d", minutes, seconds)
    }
}

// MARK: - Outlets
// MARK: - Actions
// MARK: - Properties
// MARK: Public
// MARK: Private
// MARK: - Lifecycle
// MARK: - API
// MARK: - Setups
// MARK: - Helpers
