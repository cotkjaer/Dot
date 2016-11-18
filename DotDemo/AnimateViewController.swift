//
//  ViewController.swift
//  DotDemo
//
//  Created by Christian Otkjær on 16/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit
import Dot

class AnimateViewController: UIViewController
{
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        diameterSlider.value = Float(dotWidth?.constant ?? 20)
        diameterSlider.maximumValue = Float(box.bounds.width)
        
        alphaSlider.value = Float(dot?.alpha ?? 0)
        
        animate {
            self.hueSlider.value = 0.5
            self.dot?.color = UIColor(hue: 0.5, saturation: 1, brightness: 0.8, alpha: 1)
        }
        
        dot?.backgroundColor = .clear
    }
    
    @IBOutlet weak var box: UIView!
    
    @IBOutlet weak var dot: DelegateDotView?
    @IBOutlet weak var dotWidth: NSLayoutConstraint?
    
    @IBOutlet weak var diameterSlider: UISlider!
    
    @IBOutlet weak var hueSlider: UISlider!
    
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBAction func handleSlide(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        
        switch sender
        {
        case diameterSlider:
            bounce
                {
                    self.dotWidth?.constant = value
                    
                    self.dot?.superview?.layoutIfNeeded()
            }
            
        case hueSlider:
            
            animate {
                
                self.dot?.color = UIColor(hue: value, saturation: 1, brightness: 0.8, alpha: 1)
//                self.dot?.backgroundColor = UIColor(hue: value, saturation: 1, brightness: 0.8, alpha: 1)
            }
            
        case alphaSlider:
            animate {
                self.dot?.alpha = value
            }
            
        default:
            break
        }
    }
    
    func animate(animations: @escaping ()->())
    {
        UIView.animate(withDuration: 0.1, animations: animations)
    }
    
    func bounce(animations: @escaping ()->())
    {
        UIView.animate(
            withDuration: 2,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: .beginFromCurrentState,
            animations: animations)
        { (completed) in
            
//            self.dot?.updateDotImage()
            
            debugPrint("completed: \(completed)")
        }
    }
}
