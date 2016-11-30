//
//  MoveViewController.swift
//  Dot
//
//  Created by Christian Otkjær on 30/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit
import Dot

// MARK: - random

extension CGFloat
{
    init(randomBelow: CGFloat)
    {
      self = CGFloat(arc4random_uniform(UInt32(abs(randomBelow))))
    }
}


class MoveViewController: UIViewController
{
    @IBOutlet weak var dot: Dot?
    
    @IBOutlet weak var vertical: NSLayoutConstraint!
    
    @IBOutlet weak var horizontal: NSLayoutConstraint!
    
    @IBOutlet weak var width: NSLayoutConstraint!
    
    @IBAction func handleTap(_ tap: UITapGestureRecognizer)
    {
        let location = tap.location(in: view)
        
        if dot?.frame.contains(location) == true
        {
            vertical.constant = CGFloat(randomBelow: view.bounds.height)
            
            horizontal.constant = CGFloat(randomBelow: view.bounds.width)
            
        }
        else
        {
            vertical.constant = location.y
            horizontal.constant = location.x
        }
        
        width.constant = CGFloat(randomBelow: 140) + 10
        
        view.setNeedsLayout()
        
        UIView.animate(
            withDuration: 2,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: -1,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: {
                self.view.layoutIfNeeded()
        }, completion: { (completes) in
            //NOOP
        })
    }
}
