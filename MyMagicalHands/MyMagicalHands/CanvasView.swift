//
//  CanvasView.swift
//  MyMagicalHands
//
//  Created by Do Yi Lee on 2022/03/19.
//

import UIKit

class CanvasView: UIView {
    var canvasColor: UIColor?
    var lineWidth: CGFloat?
    var path: UIBezierPath?
    var touchPoint: CGPoint?
    var startPoint: CGPoint?
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        
        let mediumLineWidth = 10.0
        self.canvasColor = UIColor.black
        self.lineWidth = mediumLineWidth
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        self.startPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        self.touchPoint = touch?.location(in: self)
        self.path = UIBezierPath()
        
        if let startingPoint = self.startPoint,
           let touchingPoint = self.touchPoint {
            self.path?.move(to: startingPoint)
            self.path?.addLine(to: touchingPoint)
            self.startPoint = touchingPoint
            drawPathLayerLine()
        }
    }

    private func drawPathLayerLine() {
        let drawingLayer = CAShapeLayer()
        drawingLayer.path = self.path?.cgPath
        if let lineColor = self.canvasColor,
           let lineWidth = self.lineWidth {
            drawingLayer.strokeColor = lineColor.cgColor
            drawingLayer.lineWidth = lineWidth
            drawingLayer.fillColor = UIColor.clear.cgColor
        }
        
        self.layer.addSublayer(drawingLayer)
        self.setNeedsDisplay()
    }
    
    func cleanCanvas() {
        self.path?.removeAllPoints()
        self.layer.sublayers = nil
        self.setNeedsDisplay()
    }
}
