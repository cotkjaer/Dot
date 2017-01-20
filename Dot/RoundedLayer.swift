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
            let updatedRadius = min(newValue.width, newValue.height) / 2
            super.cornerRadius = updatedRadius
            super.bounds = newValue
        }
        get
        {
            return super.bounds
        }
    }
    
    override func add(_ anim: CAAnimation, forKey optionalKey: String?)
    {
        guard let key = optionalKey, key.hasPrefix("bounds.size") == true, let cornerRadiusAnimation = anim.copy() as? CABasicAnimation else { super.add(anim, forKey: optionalKey); return }
   
        let groupKeySuffix = key.substring(from: key.index(key.startIndex, offsetBy: 11))
        
        cornerRadiusAnimation.keyPath = "cornerRadius"
        
        print("bounds.size: \(bounds.size), cornerRadius: \(cornerRadius)")
        
        if let p = presentation()
        {
            print("presentation - bounds.size: \(p.bounds.size), cornerRadius: \(p.cornerRadius)")
        }
        
        if let fromSize = cornerRadiusAnimation.fromValue as? CGSize
        {
            let fromValue = min(fromSize.width, fromSize.height) / 2
            
            cornerRadiusAnimation.fromValue =  fromValue
            
            print("fromSize: \(fromSize), toValue: \(fromValue)")
        }
        else
        {
            cornerRadiusAnimation.fromValue = nil
        }
        
        if let toSize = cornerRadiusAnimation.toValue as? CGSize
        {
            let toValue = min(toSize.width, toSize.height) / 2
            
            cornerRadiusAnimation.toValue = toValue
            
            print("toSize: \(toSize), toValue: \(toValue)")
        }
        else
        {
            cornerRadiusAnimation.toValue = nil
        }
        
        let group = CAAnimationGroup()
        
        group.timingFunction = anim.timingFunction
        group.delegate = anim.delegate
        group.beginTime = anim.beginTime
        
        group.duration = anim.duration
        
        group.animations = [anim,cornerRadiusAnimation]
        
        add(group, forKey: "cornerRadius+bounds.size" + groupKeySuffix)
    }
}

