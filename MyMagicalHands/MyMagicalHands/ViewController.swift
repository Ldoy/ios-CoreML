//
//  ViewController.swift
//  MyMagicalHands
//
//  Created by Do Yi Lee on 2022/02/05.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var guessShapeButton: UIButton!
    
    @IBAction func cleanCanvas(_ sender: Any) {
        self.canvasView.cleanCanvas()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController {

}
