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
        let numberOfImageAsPattern = CGFloat(100.0)
        guard let backgroundImage = background?.resizeImage(numberOfImageAsPattern,
                                                            opaque: false) else  {
            return
        }
        
        self.view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
}

extension UIImage {
      func resizeImage(_ dimension: CGFloat,
                       opaque: Bool,
                       contentMode: UIView.ContentMode = .scaleAspectFill) -> UIImage {
          var width: CGFloat
          var height: CGFloat
          var newImage: UIImage

          let size = self.size
          let aspectRatio =  size.width/size.height

          switch contentMode {
              case .scaleAspectFill:
                  if aspectRatio > 1 {                            // Landscape image
                      width = dimension
                      height = dimension / aspectRatio
                  } else {                                        // Portrait image
                      height = dimension
                      width = dimension * aspectRatio
                  }

          default:
              fatalError("UIIMage.resizeToFit(): FATAL: Unimplemented ContentMode")
          }

          if #available(iOS 10.0, *) {
              let renderFormat = UIGraphicsImageRendererFormat.default()
              renderFormat.opaque = opaque
              let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: renderFormat)
              newImage = renderer.image {
                  (context) in
                  self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
              }
          } else {
              UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), opaque, 0)
                  self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
                  newImage = UIGraphicsGetImageFromCurrentImageContext()!
              UIGraphicsEndImageContext()
          }

          return newImage
      }
  }
