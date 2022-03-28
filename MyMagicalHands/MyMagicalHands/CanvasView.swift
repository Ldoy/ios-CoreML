//
//  CanvasView.swift
//  MyMagicalHands
//
//  Created by Do Yi Lee on 2022/03/19.
//

import UIKit

enum CanvasViewLineWidth: Double {
    case medium = 20.0
}

class CanvasView: UIView {
    var canvasColor: UIColor?
    var lineWidth: CGFloat?
    var path: UIBezierPath?
    var touchPoint: CGPoint?
    var startPoint: CGPoint?
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        
        self.canvasColor = UIColor.black
        self.lineWidth = CanvasViewLineWidth.medium.rawValue
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
            drawingLayer.lineCap = .round
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
    
    func captureCurrentCanvas() -> CGImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size,
                                               layer.isOpaque, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        self.layer.render(in: context)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let output = outputImage {
            return output.convert()
        } else {
            return nil
        }
    }
}

extension UIImage {
    func convert() -> CGImage? {
        guard let ciimage = CIImage(image: self) else {
            return nil
        }
        
        let context = CIContext()
        let cgImage = context.createCGImage(ciimage , from: ciimage.extent)
        return cgImage
    }
}


// undo 매니저
