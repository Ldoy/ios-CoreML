//
//  ViewController.swift
//  MyMagicalHands
//
//  Created by Do Yi Lee on 2022/02/05.
//

import UIKit
import CoreML

var images: [UIImage] = []

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var testResultRabel: UILabel!
    
    @IBAction func cleanCanvas(_ sender: Any) {
        self.canvasView.cleanCanvas()
    }
    
    @IBAction func guessShape(_ sender: Any) {
        let output = self.canvasView.captureCurrentCanvas()
        
        if let outputImgae = output {
            images.append(outputImgae)
            self.testImage.image = outputImgae
        }
        self.canvasView.cleanCanvas()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController {

}
