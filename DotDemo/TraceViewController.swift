//
//  TraceViewController.swift
//  Dot
//
//  Created by Christian Otkjær on 17/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit
import Dot

class TraceViewController: UIViewController
{
    var lastLocation : CGPoint?

    func addDot(at location: CGPoint)
    {
        let dot = Dot(frame: CGRect(center: location, size: .zero))
        
        dot.backgroundColor = .clear
        dot.fillColor = .purple
        dot.alpha = 0.5
        
        view.addSubview(dot)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0,
            options: .beginFromCurrentState,
            animations:
            {
                dot.frame = CGRect(center: location, size: CGSize(width: 10, height: 10))
                dot.alpha = 1
            })
        { (completed) in
            
            UIView.animate(
                withDuration: 6,
                delay: 1,
                options: .beginFromCurrentState,
                animations:
                {
                    dot.frame = CGRect(center: location, size: CGSize(width: 3, height: 3))

                }, completion: { (completed) in
                    dot.fillColor = .black
            })
        }
    }

    @IBAction func handlePress(_ sender: UILongPressGestureRecognizer)
    {
        let location = sender.location(in: view)
        
        switch sender.state
        {
        case .began:
            lastLocation = location
            
            addDot(at: location)
            
        case .changed:
            
            guard let lastLocation = lastLocation else { return }

            if lastLocation.distance(to: location) > 10
            {
                self.lastLocation = location
                addDot(at: location)
            }
        
        case .ended:
            addDot(at: location)
 
            fallthrough
            
        default:
            
            unravelDots()
            
            
        }
        
    }

    
    func unravelDots()
    {
        guard let firstDot = view.subviews.flatMap({ $0 as? Dot}).first else { return }
        
        UIView.animate(
            withDuration: 0.05,
            delay: 0,
//            usingSpringWithDamping: 0.3,
//            initialSpringVelocity: -1,
            options: .beginFromCurrentState, animations: {
                firstDot.alpha = 0
                firstDot.frame = CGRect(center: firstDot.frame.center, size: .zero)
            }, completion: { (completed) in
                firstDot.removeFromSuperview()
                self.unravelDots()
        })
    }

}
