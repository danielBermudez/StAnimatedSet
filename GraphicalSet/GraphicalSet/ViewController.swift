//
//  ViewController.swift
//  GraphicalSet
//
//  Created by Daniel esteban Bermudez valenzuela on 2/17/19.
//  Copyright © 2019 Daniel esteban Bermudez valenzuela. All rights reserved.
//

import UIKit
@IBDesignable

class ViewController: UIViewController {
    @IBOutlet weak var setCount: UILabel!
    var setGame = SetModel()
        var deckView = [SetCardView]()
        var frames = [CGRect]()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            guard let viewTouched = touch.view else {
                return
            }
            
           
            
            touchCard(cardNumber: viewTouched.tag)
            setGameView.setNeedsDisplay()
        }

    }
    func touchCard(cardNumber:Int){
        setGame.chooseCard(at: cardNumber)
        updateCardsFromModel()
        
    }
    func updateCardsFromModel(){
        for cardNumber in deckView.indices{
            deckView[cardNumber].changeCardColor(isSelected: setGame.gameDeck[cardNumber].isSelected)
            deckView[cardNumber].setNeedsDisplay()
             updateSetLabel()
            
        }
    }
    func updateSetLabel(){
        setCount.text = "Sets: \(setGame.numberOfSets)"
    }
    
    @IBOutlet weak var addCardsButton: UIButton!
    @IBAction func AddCards(_ sender: UIButton) {
        if (setGame.gameDeck.count == 81){
            sender.isEnabled = false
        } else {
       addCardsToGame()
            
        }
    }
    
    @objc func addCardsToGame(){
    setGame.addCardsToGame(numberOfCards: 3)
    updateCards()
    addNewCards()
    setGameView.addCards(deck: deckView)
    }
    @IBOutlet weak var setGameView : SetGameView!{
    didSet{
        setGameView.tag = 100
        setGame.startGame()
        setGame.fillDeck()
        initialCards()
        setGameView.addCards(deck: deckView)
        }}
    private func setColorFromModel(color :String)->UIColor?{
        if(color == "red"){
            return UIColor.red
        }else if(color == "green"){
            return  UIColor.green
        }else if (color == "blue"){
            return   UIColor.blue
        }else{ return nil}
        
    }
    
    private func initialCards(){
        // TO DO Restore 
       updateFrames()        
        for index in setGame.gameDeck.indices{
            let emptyCard = SetCardView()
            let card = setGameView.drawCard(cardToDraw: emptyCard,shape: setGame.gameDeck[index].shape, numberOfShapes: setGame.gameDeck[index].numberOfShapes, shade: setGame.gameDeck[index].shade, color: setColorFromModel(color:setGame.gameDeck[index].color)!, frame: frames[index])
            card.tag = index;
            deckView.append(card)
            
      }
        
    }
    private func updateFrames(){
      frames = setGameView.addCards(NumberOFcards: setGame.gameDeck.count)
    }
    private func updateCards(){
            updateFrames()
        for i  in deckView.indices {
            setGameView.cleanCardDraw(card: deckView[i])
            deckView[i] = setGameView.drawCard(cardToDraw: deckView[i],shape: setGame.gameDeck[i].shape, numberOfShapes: setGame.gameDeck[i].numberOfShapes, shade: setGame.gameDeck[i].shade, color: setColorFromModel(color:setGame.gameDeck[i].color)!, frame: frames[i])
        }
    
        
    }
    private func addNewCards(){
        updateFrames()
        for index in deckView.count ... (setGame.gameDeck.count - 1 ) {
            let emptyCard = SetCardView()
            let card = setGameView.drawCard(cardToDraw: emptyCard,shape: setGame.gameDeck[index].shape, numberOfShapes: setGame.gameDeck[index].numberOfShapes, shade: setGame.gameDeck[index].shade, color: setColorFromModel(color:setGame.gameDeck[index].color)!, frame: frames[index])
            card.tag = index;
            deckView.append(card)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
         NotificationCenter.default.addObserver(self, selector: #selector(updateCardsSize), name: UIDevice.orientationDidChangeNotification, object: nil)
          
            swypeDownAddMoreCards()
        
    }
    @objc func updateCardsSize(){
    updateFrames()
    updateCards()
    setGameView.addCards(deck: deckView)
    }
    func swypeDownAddMoreCards(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(addCardsToGame))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }

    @IBAction func restartGame(_ sender: Any) {
         setGame.restartGame()
        deckView.removeAll()
        setGameView.cleanView()
        initialCards()
       setGameView.addCards(deck: deckView)
        
        updateSetLabel()
        addCardsButton.isEnabled = true
    }
    
}


