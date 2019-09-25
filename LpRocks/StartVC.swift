//
//  ViewController.swift
//  LpRocks
//
//  Created by Trig Gullberg on 2/3/18.
//  Copyright © 2018 Trig Gullberg. All rights reserved.
//

import UIKit
import Leanplum
import AVFoundation

class StartVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var theSpinner: UIActivityIndicatorView!
    //@IBOutlet var spinnerView: UIView!
    @IBOutlet var mainButton: UIButton!
    @IBOutlet var emailText: UITextField!
    //@IBOutlet var callToActionButton: UIButton!
//    var blurEffectView: UIVisualEffectView!
    var theEffect: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.spinnerView.isHidden = true
        self.theSpinner.isHidden = true
        mainButton.layer.cornerRadius = 7
        //callToActionButton.layer.cornerRadius = 7
        
        // button effect
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        
        //let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        //mainButton.frame = CGRectMake(100, 100, 200, 40)
        mainButton.setTitle("", for: UIControlState.normal)
        mainButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        mainButton.backgroundColor = UIColor.clear
        mainButton.layer.borderWidth = 2.0
        mainButton.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        mainButton.layer.cornerRadius = cornerRadius
        
        emailText.layer.borderWidth = 2.0
        emailText.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).cgColor
        emailText.layer.cornerRadius = cornerRadius
        
        let leftView = UILabel(frame: CGRect(x: 10, y: 0, width: 7, height: 10))
        leftView.backgroundColor = .clear
        
        emailText.leftView = leftView
        emailText.leftViewMode = .always
        emailText.contentVerticalAlignment = .center
        
        // blur effect
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        backgroundImage.addSubview(blurEffectView)
 
        Leanplum.onVariablesChanged {
            DispatchQueue.main.async() {
                
                //self.doText()
                //self.doNewAnimation()
                
//                self.blurEffectView.removeFromSuperview()
                
                self.backgroundImage.image = backGroundImage?.imageValue()
                //self.callToActionButton.setTitle(callToActionText?.stringValue(), for: UIControlState.normal)
                self.mainButton.setTitle(mainButtonText?.stringValue(), for: UIControlState.normal)
                
 
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func clickGoButton(sender: AnyObject) {
        Leanplum.advance(to: "Begin Onboarding")
        Leanplum.track("Go Button Click")
        
        switch onboardingOption.intValue() {
            case 1:
                showTheView(controlerName: "OnboardingOne")
            case 2:
                showTheView(controlerName: "OnboardingTwo")
            case 3:
                showTheView(controlerName: "OnboardingThree")
            default:
                showTheView(controlerName: "OnboardingOne")
        }
    }
    
    @IBAction func clickSound(sender: AnyObject) {
        
        let path = audioFile.fileValue()
        let url = URL(fileURLWithPath: path!)
        
        do {
            theEffect = try AVAudioPlayer(contentsOf: url)
            theEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func showTheView(controlerName: String) {
        let src: UIViewController = self
        let dst : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: controlerName)
        src.present(dst as! UIViewController, animated: true, completion: nil)
    }
    
    /*
    func doNewAnimation() {
        self.spinnerView.isHidden = false
        self.spinnerView.backgroundColor = UIColor.white
        self.spinnerView.frame.size = self.view.bounds.size
        let size = CGSize(width: 50, height: 50)
        //startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballScaleMultiple)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.pacman)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            self.stopAnimating()
            self.spinnerView.isHidden = true
        }
    }
 */
    
    
    func getPathForLetter(letter: Character) -> UIBezierPath {
        var path = UIBezierPath()
        let font = CTFontCreateWithName("HelveticaNeue" as CFString, 64, nil)
        
        var unichars = [UniChar]("\(letter)".utf16)
        var glyphs = [CGGlyph](repeating: 0, count: unichars.count)
        
        let gotGlyphs = CTFontGetGlyphsForCharacters(font, &unichars, &glyphs, unichars.count)
        if gotGlyphs {
            let cgpath = CTFontCreatePathForGlyph(font, glyphs[0], nil)
            if cgpath != nil {
                path = UIBezierPath(cgPath: cgpath!)
            } else {
                //print("got a space: " + letter.description)
                //let glyph = glyphs[0]
                let f = CTFontCreateForString(font, " " as CFString, CFRangeMake(0,1))
                print("space CTFontGetLeading: " + CTFontGetLeading(f).description)
                print("space CTFontGetBoundingBox: " + CTFontGetBoundingBox(f).debugDescription)
                
                path = UIBezierPath(rect: CTFontGetBoundingBox(f))
               
            }
            //path = UIBezierPath(cgPath: cgpath!)
        }
        
        return path
    }
    
    func doText() {
        
        let word = "Testing is Cool"
        let path = UIBezierPath()
        //let spacing: CGFloat = 50
        var i: CGFloat = 0
        var theWidth: CGFloat = 0.0
        
        for letter in word {
            let newPath = getPathForLetter(letter: letter)
            print("new width: " + newPath.cgPath.boundingBox.width.description)
            print("theWidth: " + theWidth.description)
            theWidth = newPath.cgPath.boundingBox.width + theWidth + 20
            
            //let actualPathRect = path.cgPath.boundingBox
            //let transform = CGAffineTransform(translationX: (actualPathRect.width + min(i, 1)*newPath.cgPath.boundingBox.width), y: 0)
            let transform = CGAffineTransform(translationX: (theWidth), y: 0)
            newPath.apply(transform)
            path.append(newPath)
            i += 1
        }
        
        let layer = CAShapeLayer()
        
        layer.position = CGPoint(x: 20, y: 200)
        layer.bounds = CGRect()
        view.layer.addSublayer(layer)
        
        layer.path = path.cgPath
        
        layer.lineWidth = 5.0
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.isGeometryFlipped = true
        
        layer.strokeStart = 0.0
        layer.strokeEnd = 1.0
        
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        anim.duration = 8.0
        anim.fromValue = 0.0
        anim.toValue = 1.0
        
        layer.add(anim, forKey: nil)
    }

}

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

