//
//  MainVC.swift
//  LpRocks
//
//  Created by Trig Gullberg on 2/24/18.
//  Copyright © 2018 Trig Gullberg. All rights reserved.
//

import Foundation
import UIKit
import Leanplum

class MainVC: UIViewController {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button effect
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        //let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        //mainButton.frame = CGRectMake(100, 100, 200, 40)
        backButton.setTitle("Back", for: UIControlState.normal)
        backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backButton.backgroundColor = UIColor.clear
        backButton.layer.borderWidth = 2.0
        backButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        backButton.layer.cornerRadius = cornerRadius
        
        // blur effect
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        backgroundImage.addSubview(blurEffectView)
        
        Leanplum.onVariablesChanged {
            DispatchQueue.main.async() {
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


