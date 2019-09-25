//
//  OnBoardViewController.swift
//  LpRocks
//
//  Created by Trig Gullberg on 2/24/18.
//  Copyright © 2018 Trig Gullberg. All rights reserved.
//

import UIKit
import Leanplum

class OnboardVC: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 7
        backButton.layer.cornerRadius = 7
        
        // button effect
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        //let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        //mainButton.frame = CGRectMake(100, 100, 200, 40)
        nextButton.setTitle("Next", for: UIControlState.normal)
        nextButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        nextButton.backgroundColor = UIColor.clear
        nextButton.layer.borderWidth = 2.0
        nextButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        nextButton.layer.cornerRadius = cornerRadius
        
        backButton.setTitle("Back", for: UIControlState.normal)
        backButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        backButton.backgroundColor = UIColor.clear
        backButton.layer.borderWidth = 2.0
        backButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        backButton.layer.cornerRadius = cornerRadius
        
        // blur effect
        /*
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundImage.addSubview(blurEffectView)
 */
        
        Leanplum.onVariablesChanged {
            DispatchQueue.main.async() {
                /*
                 self.spinnerView.isHidden = false
                 self.spinnerView.backgroundColor = UIColor.white
                 self.spinnerView.frame.size = CGSize(width: 750, height: 1400)
                 self.doNewAnimation()
                 
                 self.bgImage.image = bgImage1?.imageValue()
                 self.mainButton.setTitle(screen1Msg?.stringValue(), for: UIControlState.normal)
                 self.goButton.setTitle(promoText?.stringValue(), for: UIControlState.normal)
                 */
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickNextButton(sender: AnyObject) {
        Leanplum.track("Next Button Click")
    }




}
