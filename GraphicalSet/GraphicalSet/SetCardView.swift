//
//  SetCardView.swift
//  GraphicalSet
//
//  Created by Daniel esteban Bermudez valenzuela on 2/17/19.
//  Copyright © 2019 Daniel esteban Bermudez valenzuela. All rights reserved.
//

import UIKit

class SetCardView: UIView {
    var rounderRect = UIBezierPath()
    var isSelected = false
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        // Drawing code
        
        rounderRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        if isSelected == false {
        UIColor.white.setFill()
        UIColor.cyan.setStroke()
        rounderRect.fill()
        rounderRect.stroke()
        }else{
           
          UIColor.cyan.setFill()
            rounderRect.fill()
        }

      
//       let path = drawTriangles(center: self.bounds,numberOfShapes:2)
//        for index in path.indices{
//            setcolor(color: UIColor.green, path: path[index],alpha: 0.5, fill: true)
//
//        }
        
    }

    func changeCardColor(isSelected: Bool) {
        self.isSelected = isSelected
        
        
    }

    func  removeShape(){
        let sublayers = self.layer.sublayers
        for layer in sublayers! {
            layer.removeFromSuperlayer()
        }
        self.layer.needsDisplay()
        
    }
    func drawTriangles(center:CGRect,numberOfShapes: CGFloat)->[UIBezierPath]{
        var triangles = [UIBezierPath]()
        var scale = CGFloat()
        var xposition = CGFloat()
        
        
        if(numberOfShapes>1){
            scale = center.width / numberOfShapes
            xposition = scale/2
        }else {
            scale = center.width / CGFloat(2)
            xposition = scale
        }
        let side = (scale/numberOfShapes)
        
        for  i in  0 ..< Int(numberOfShapes.magnitude) {
            
            let startX = (center.minX+((scale*CGFloat(i)+xposition)))
            let startY = center.midY - (side/3)
            let path = UIBezierPath()
            path.move(to: CGPoint(x: startX, y: startY))
            path.addLine(to: CGPoint(x: startX - (side/2) , y: startY + side / 2))
            path.addLine(to: CGPoint(x: startX + (side/2), y: startY + side / 2))
            path.close()
            triangles.append(path)
        }
        return triangles
        
    }
    func drawSquares(center:CGRect,numberOfShapes: CGFloat)->[UIBezierPath]{
        
        var squares = [UIBezierPath]()
        var scale = CGFloat()
        var xposition = CGFloat()
        if(numberOfShapes>1){
            scale = center.width / numberOfShapes
            xposition = scale/2
        }else {
            scale = center.width / CGFloat(2)
            xposition = scale
        }
        
        let side = (scale/numberOfShapes)
        for  i in  0 ..< Int(numberOfShapes.magnitude) {
            let startX = (center.minX+((scale*CGFloat(i)+xposition)))-(side/2)
            let startY = center.midY - (side/2)
            let path = UIBezierPath(rect: CGRect(x:startX,y:startY,width:side,height:side))
            path.close()
            squares.append(path)
        }
        return squares
        
    }
    func drawCircles(center:CGRect,numberOfShapes: CGFloat)->[UIBezierPath]{
        
        var circles = [UIBezierPath]()
        var scale = CGFloat()
        var xposition = CGFloat()
        if(numberOfShapes>1){
            scale = center.width / numberOfShapes
            xposition = scale/2
        }else {
            scale = center.width / CGFloat(2)
            xposition = scale
        }
        for  i in  0 ..< Int(numberOfShapes.magnitude) {
            let path = UIBezierPath()
            path.addArc(withCenter:CGPoint(x:(center.minX+((scale*CGFloat(i)+xposition))), y:center.midY), radius: (scale/(numberOfShapes*2)), startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
            path.lineWidth = 5.0
            path.close()
            circles.append(path)
        }
        return circles
    }
    
    func setcolor(color:UIColor, path:UIBezierPath, alpha:CGFloat,fill: Bool){
       let colorwithalpha =  color.cgColor.copy(alpha:alpha)
      let shapeLayer = CAShapeLayer()
       
       
        shapeLayer.path = path.cgPath
        
        if (fill){
            shapeLayer.fillColor = colorwithalpha
        }else{
    shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.lineWidth = 5.0
            shapeLayer.strokeColor = colorwithalpha
        }
      

        self.layer.addSublayer(shapeLayer)

    }

}
extension SetCardView{
    private struct SizeRatio{
        static let cornerFontsizeToBoundsHeight : CGFloat = 0.085
        static let cornerRadiusToBoundsHeight : CGFloat = 0.06
        static let cornerOffsetToCornerRadius : CGFloat = 0.033
        static let faceCardImageSizeToBoundsSize : CGFloat = 0.75
    }
    private var cornerRadius:CGFloat{
        return bounds.size.height*SizeRatio.cornerRadiusToBoundsHeight
    }
    
}
