//
//  TapViewController.swift
//  Dot
//
//  Created by Christian Otkjær on 17/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit
import Dot

class TapViewController: UIViewController {

    @IBAction func handleTap(_ sender: UITapGestureRecognizer)
    {
        let location = sender.location(in: view)
        
        let dot = Dot(frame: CGRect(center: location, size: CGSize(width: 0, height: 0)))
        
//        dot.animatable = true
        
        dot.backgroundColor = .clear
        dot.color = .orange
        dot.alpha = 0.5
//        dot.isUserInteractionEnabled = false
        
        view.addSubview(dot)
        
        UIView.animate(
            withDuration: 5,
            delay: 0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0,
            options: .beginFromCurrentState,
            animations:
            {
                dot.frame = CGRect(center: location, size: CGSize(width: 40, height: 40))
                dot.alpha = 1
            })
        { (completed) in
                
                UIView.animate(
                    withDuration: 2,
                    delay: 2,
                    options: .beginFromCurrentState,
                    animations:
                    {
                        dot.alpha = 0
                    }, completion: { (completed) in
                        dot.removeFromSuperview()
                })
        }
    }
}
