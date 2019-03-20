//
//  SetCard.swift
//  setGame
//
//  Created by Daniel Bermudez on 2/11/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import UIKit
struct setCard{
    
    private(set) var shape :String = " "
    private(set)var numberOfShapes : Int = 0
    private(set)var color : String = ""
    private(set) var shade:String = " "
    
    
    private(set) var isSelected = false
    mutating func setSelected(selection: Bool){
        isSelected = selection
    }
    mutating func setShape(shape:String){
        self.shape = shape
    }
    mutating func setNumber(numberOfShapes:Int){
        self.numberOfShapes = numberOfShapes
    }
    mutating func setColor(color:String){
        self.color = color
    }
    mutating func setshade(shade:String){
        self.shade = shade
    }
    
    
    
    

}
struct setCardCaracteristics{
    enum shapes:String, CaseIterable{
        case triangle 
        case circle
        case square      
    }
    enum  numberOfShapes :Int,CaseIterable{
        case one = 1,two = 2,three = 3
    }
    enum colors: String ,CaseIterable{
        case red
        case green
        case blue
    }
    enum shadings:String , CaseIterable{
        case unfilled
        case softFilling
        case strongFilling
    }

}
