//
//  ViewController.swift
//  MyMagicalHands
//
//  Created by Do Yi Lee on 2022/02/05.
//

import UIKit
import CoreML

var drawing: [CGImage] = []
var result: [String : Double] = [:]

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var testResultRabel: UILabel!
    
    @IBAction func cleanCanvas(_ sender: Any) {
        self.canvasView.cleanCanvas()
    }
    
    @IBAction func guessShape(_ sender: Any) {
        let currentCanvas = self.canvasView.captureCurrentCanvas()
        
        if let outputImage = currentCanvas {
            drawing.append(outputImage)
        }
        
        self.predictImage()
        
        let answer = result.filter { element in
            return element.value >= 1.0
        }
        print(answer.keys)
        testResultRabel.text = "\(answer.keys.first ?? "다시 그리셔야 할 것")처럼 보이네요"
      
        self.canvasView.cleanCanvas()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {
    private func predictImage() {
        let configuration = MLModelConfiguration()
        do {
            let model = try ShapDetector(configuration: configuration)
            
            guard let latestDrawing = drawing.last else {
                return
            }
            
            let input = try ShapDetectorInput(imageWith: latestDrawing)
            let output = try model.prediction(input: input)
            result = output.class_
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
