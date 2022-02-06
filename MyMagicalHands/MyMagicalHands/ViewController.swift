//
//  ViewController.swift
//  MyMagicalHands
//
//  Created by Do Yi Lee on 2022/02/05.
//

import UIKit

fileprivate let background = UIImage(named: "drawing")

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        renderBackgroundImage()
    }

}

extension ViewController {
    private func renderBackgroundImage() {
        guard let backgroundImage = background else  {
            return
        }
        
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
}
