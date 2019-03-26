//
//  Set.swift
//  setGame
//
//  Created by Daniel Bermudez on 2/12/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
class SetModel{
    private var completeDeck = [setCard]()
    private(set) var cardsShown = 12
    private(set) var maxcardsShown = 24

    private var selectedCardsIndexs = [-1,-1]
    private(set) var numberOfSets = 0
    private(set) var score = 0
    private(set) var gameDeck = [setCard]()
    func fillDeck(){
        for numberOfShapes in setCardCaracteristics.numberOfShapes.allCases{
            for shape in setCardCaracteristics.shapes.allCases{
                for color in setCardCaracteristics.colors.allCases{
                for shade in setCardCaracteristics.shadings.allCases{
                    var card = setCard()
                    card.setNumber(numberOfShapes: numberOfShapes.rawValue)
                    card.setShape( shape: shape.rawValue)
                    card.setColor( color: color.rawValue)
                     card.setshade(shade: shade.rawValue)
                    card.setFaceDown(selection: true )
                    completeDeck.append(card)
                    }
                }
            }
    }
    }
    func chooseCard(at index :Int){
//        No Cards Selected
        if index < 81 {
        if selectedCardsIndexs.contains(index){
             gameDeck[index].setSelected(selection: false)
            selectedCardsIndexs[selectedCardsIndexs.firstIndex(of: index)!] = -1
        } else if(selectedCardsIndexs[0] == -1 && selectedCardsIndexs[1] == -1){
            selectedCardsIndexs[0] = index
            gameDeck[index].setSelected(selection: true)
//            One card selected
        } else if(selectedCardsIndexs[0] != -1 && selectedCardsIndexs[1] == -1){
            selectedCardsIndexs[1] = index
            gameDeck[index].setSelected(selection: true)
//       two cards selected
        } else if(selectedCardsIndexs[0] == -1 && selectedCardsIndexs[1] != -1){
            selectedCardsIndexs[0] = index
            gameDeck[index].setSelected(selection: true)
            //       two cards selected
        }
        else{
            if(validateSet(cards:(gameDeck[selectedCardsIndexs[0]],gameDeck[selectedCardsIndexs[1]],gameDeck[index]))){
               numberOfSets = numberOfSets + 1                
            }
            deselectCards()
            }    }   }
//    func dealAdditionalCards(numberOfCards:Int){
//    if((cardsShown+numberOfCards)<=maxcardsShown){
//        cardsShown = cardsShown + numberOfCards
//        addCardsToGame(numberOfCards: numberOfCards)
//
//        }}
    func flipCard(index : Int){
            gameDeck[index].setFaceDown(selection: !gameDeck[index].isFaceDown)        
    }
    func deselectCards(){
        selectedCardsIndexs = [-1,-1]
        for flipDownIndex in gameDeck.indices{
            gameDeck[flipDownIndex].setSelected(selection: false)
        }
    }
    func restartGame(){
        completeDeck.removeAll()
        gameDeck.removeAll()
        fillDeck()
        cardsShown = 12
        addCardsToGame(numberOfCards: cardsShown)
        numberOfSets = 0
        score = 0
        selectedCardsIndexs = [0,0]
    }
    func dealAdditionalCards(numberOfCards:Int){
        if((cardsShown+numberOfCards)<=maxcardsShown){
            cardsShown = cardsShown + numberOfCards
            addCardsToGame(numberOfCards: numberOfCards)
            
        }}
    func validateSet(cards:(firstCard:setCard,secondCard:setCard,thirdCard:setCard) )-> Bool{
        let shapeVal = validateStringCharacteristic(first: cards.firstCard.shape,second: cards.secondCard.shape,third:cards.thirdCard.shape)
         let colorVal = validateStringCharacteristic(first: cards.firstCard.color,second: cards.secondCard.color,third:cards.thirdCard.color)
        let shadeVal = validateStringCharacteristic(first: cards.firstCard.shade,second: cards.secondCard.shade,third:cards.thirdCard.shade)
         let numberVal = validateIntCharacteristic(first: cards.firstCard.numberOfShapes,second: cards.secondCard.numberOfShapes,third:cards.thirdCard.numberOfShapes)
        if(shapeVal && colorVal && shadeVal && numberVal){
            return true
        }else {return false}
        
        
    }
    func validateStringCharacteristic(first:String,second:String,third:String)-> Bool{
        if((first == second) && (first == third) && (second == third)){
            return true
        }else if ((first != second) && (first != third) && (second != third)){
            return true
        }else{
            return false
        }
    }
    func validateIntCharacteristic(first:Int,second:Int,third:Int)-> Bool{
        if((first == second) && (first == third) && (second == third)){
            return true
        }else if ((first != second) && (first != third) && (second != third)){
            return true
        }else{
            return false
        }
    }
    func startGame(){        
        fillDeck()
        addCardsToGame(numberOfCards: cardsShown)
    }
    func addCardsToGame(numberOfCards:Int){
        if (gameDeck.count + numberOfCards) <= 81{
        for _ in 0 ..< numberOfCards{
            let randomCardIndex = completeDeck.index(completeDeck.startIndex, offsetBy: completeDeck.count.arc4random)
            let randomCard = completeDeck[randomCardIndex]
            gameDeck.append(randomCard)
            completeDeck.remove(at: randomCardIndex)
        }
        }}
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}

