//
//  Game.swift
//  Find Number
//
//  Created by Игорь Тимофеев on 5.11.21.
//

import UIKit

enum StatusGame {
    case start
    case win
}

class Game {
    
    struct Item { // отвечает за кнопки в игре
        var title: String
        var isFound: Bool = false
    }
    
    private let data = Array (1...99) // массив цифр, из которого мы будем выбирать нужное количество и отображать на кнопках во время игры
    
    var items: [Item] = [] // массив с айтемами
    
    private var countItems: Int //
    
    var nextItem: Item?
    
    var status: StatusGame = .start
    
    init(countItems: Int) {
        self.countItems = countItems
        setupGame()
    }
    
    private func setupGame() {
        var digits = data.shuffled()
   
        while items.count < countItems {
            let item = Item(title: String(digits.removeFirst()))
            items.append(item)
    }
        nextItem = items.shuffled().first
}
    func check(index: Int) {
        if items[index].title == nextItem?.title {
           items[index].isFound = true
            nextItem = items.shuffled().first(where: { (item) -> Bool in
                item.isFound == false
            })
        }
        
        if nextItem == nil {
            status = .win
        }
    }
}
