//
//  RoundedLayer.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

class RoundedLayer: CALayer
{
    override var bounds: CGRect
        {
        set
        {
            //            path = UIBezierPath(ovalIn: super.bounds).cgPath
            
            let updatedRadius = min(newValue.width, newValue.height) / 2
//            
//            if let b = action(forKey: "backgroundColor") as? CABasicAnimation
//            {
//                let radius = presentation()?.cornerRadius ?? cornerRadius
//                b.keyPath = "cornerRadius"
//                b.fromValue = radius
//                b.toValue = nil
//                b.fillMode = kCAFillModeRemoved
//                
//                cornerRadius = updatedRadius
//                add(b, forKey: "cornerRadius")
//            }
//            else
//            {
//                cornerRadius = updatedRadius
//            }
            super.cornerRadius = updatedRadius
            super.bounds = newValue
        }
        get
        {
            return super.bounds
        }
    }
    
    override func add(_ anim: CAAnimation, forKey key: String?)
    {
        guard let k = key, k.hasPrefix("bounds.size") == true, let a = anim.copy() as? CABasicAnimation else { super.add(anim, forKey: key); return }
   
        let groupKeySuffix = k.substring(from: k.index(k.startIndex, offsetBy: 11))
        
        a.keyPath = "cornerRadius"
        if let fromSize = a.fromValue as? CGSize
        {
            a.fromValue = min(fromSize.width, fromSize.height) / 2
        }
        else
        {
            a.fromValue = nil
        }
        
        if let toSize = a.toValue as? CGSize
        {
            a.toValue = min(toSize.width, toSize.height) / 2
        }
        else
        {
            a.toValue = nil
        }
        
        let group = CAAnimationGroup()
        
        group.timingFunction = anim.timingFunction
        group.delegate = anim.delegate
        group.beginTime = anim.beginTime
        
        //        group.fillMode = anim.fillMode
        group.duration = anim.duration
        
        group.animations = [anim,a]
        
        add(group, forKey: "cornerRadius+bounds.size" + groupKeySuffix)
    }
}

