import UIKit

enum StatusGame {
    case start
    case win
    case lose
}

final class Game {
  
    struct Item { // отвечает за кнопки в игре
        var title: String
        var isFound = false
        var isError = false
    }
    
    private let data = Array (1...99) // массив цифр, из которого мы будем выбирать нужное количество и отображать на кнопках во время игры
    
    var items: [Item] = [] // массив с айтемами
    
    private var countItems: Int //кол-во айтемов в нашем массие items
    
    var nextItem: Item?
    
    var status: StatusGame = .start {
        didSet {
            if status != .start {
                stopGame()
            }
        }
    }
    private var timeForGame: Int
    private var secondsGame: Int {
        didSet {
            if secondsGame == 0 {
                status = .lose
            }
            updateTimer(status, secondsGame)
        }
    }
    
    
    private var timer: Timer?
    private var updateTimer: ((StatusGame, Int) -> Void)
    
    init(countItems: Int, time: Int, updateTimer: @escaping (_ status: StatusGame, _ seconds: Int) -> Void) {
        self.countItems = countItems
        self.timeForGame = time
        self.secondsGame = time
        self.updateTimer = updateTimer
        setupGame()
    }
}

// MARK: Functions
extension Game {
    
    private func setupGame() {
        var digits = data.shuffled()
        items.removeAll()
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
        }
        
        nextItem = items.shuffled().first
        updateTimer(status, secondsGame)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self](_) in
            self?.secondsGame -= 1
        })
    }
    
    func newGame(){
        status = .start
        self.secondsGame = self.timeForGame
        setupGame()
    }
    
    func check(index: Int) {
        guard status == .start else {return}
        if items[index].title == nextItem?.title {
            items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        } else {
            items[index].isError = true
        }
        
        if nextItem == nil {
            status = .win
        }
    }
    
    func stopGame() {
        timer?.invalidate()
    }
}
