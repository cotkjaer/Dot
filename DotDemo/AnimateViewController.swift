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
            self.dot?.fillColor = UIColor(hue: 0.5, saturation: 1, brightness: 0.8, alpha: 1)
        }
        
//        dot?.backgroundColor = .clear
    }
    
    @IBOutlet weak var box: UIView!
    
    @IBOutlet weak var dot: Dot?
    @IBOutlet weak var dotWidth: NSLayoutConstraint?
    
    @IBOutlet weak var diameterSlider: UISlider!
    
    @IBOutlet weak var hueSlider: UISlider!
    
    @IBOutlet weak var alphaSlider: UISlider!
    
    @IBAction func handleSlide(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        
        switch sender
        {
        case diameterSlider:
            
//             bounce
            animate
                {
                    self.dotWidth?.constant = value
                    
                    self.dot?.superview?.layoutIfNeeded()
            }
            
        case hueSlider:
            
            animate {
                
                self.dot?.fillColor = UIColor(hue: value, saturation: 1, brightness: 0.8, alpha: 1)
            }
            
        case alphaSlider:
            animate {
                self.dot?.alpha = value
            }
            
        default:
            break
        }
    }
    @IBAction func handle(_ tap: UITapGestureRecognizer)
    {
        guard tap.state == .ended else { return }
        
        let location = tap.location(in: tap.view)
        
        bounce
            {
                self.diameterSlider.value = Float(location.x)
                self.dotWidth?.constant = location.x
                self.dot?.layer.borderWidth = location.x / 20
                
                self.dot?.layer.borderColor = UIColor.orange.cgColor
                
                tap.view?.layoutIfNeeded()
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
            // NOOP
        }
    }
}
