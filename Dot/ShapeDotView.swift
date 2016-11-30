//
//  ShapeDotView.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

class ShapeLayer : CAShapeLayer
{
    /*
    // Implicit path animation
    override func action(forKey event: String) -> CAAction?
    {
        if event == "path"
        {
            let animation = CABasicAnimation(keyPath:event)
            animation.duration = CATransaction.animationDuration()
            animation.timingFunction = CATransaction.animationTimingFunction()
            return animation
        }
        
        return super.action(forKey: event)
    }
    */
    override func add(_ anim: CAAnimation, forKey key: String?)
    {
        if let a = anim as? CABasicAnimation
        {
            print (a.debugDescription)
        }
        
        super.add(anim, forKey: key)
        
        if let basicAnimation = anim as? CABasicAnimation, basicAnimation.keyPath == "bounds.size"
        {
            if let pathAnimation = basicAnimation.copy() as? CABasicAnimation
            {
                pathAnimation.keyPath = "path"
                
                // The path property has not been updated to the new value yet
                
                pathAnimation.fromValue = path
                pathAnimation.toValue = path(forBounds: bounds)
                
                add(pathAnimation, forKey: "path")
            }
            
        }
        
    }
    
    //    override func animation(forKey key: String) -> CAAnimation?
    //    {
    //        let anim = super.animation(forKey: key)
    //
    //        print("\((anim as? CABasicAnimation)?.keyPath)")
    //
    //        return anim
    //    }
    
    func path(forBounds: CGRect) -> CGPath
    {
        return UIBezierPath(ovalIn: forBounds).cgPath
    }
    //
    //    override var path: CGPath?
    //        {
    //        set {}
    //        get { return path(forBounds: presentation()?.bounds ?? bounds) }
    //    }
    //
    //    override func draw(in ctx: CGContext)
    //    {
    //        path = path(forBounds: bounds)
    //        super.draw(in: ctx)
    //    }
}

@IBDesignable
open class ShapeDotView: UIView
{
    private var shapeLayer : ShapeLayer? { return layer as? ShapeLayer }
    
    override open class var layerClass : AnyClass
    {
        return ShapeLayer.self
    }
    
    @IBInspectable
    open var fillColor: UIColor?
        {
        set { shapeLayer?.fillColor = newValue?.cgColor }
        get { return shapeLayer?.fillColor?.uiColor }
    }
    
    open var path : UIBezierPath?
        {
        set
        {
            shapeLayer?.path = newValue?.cgPath
            //            if let anim = layer.animation(forKey: "backgroundColor") as? CABasicAnimation
            //            {
            //                anim.keyPath = "path"
            //                anim.fromValue = shapeLayer?.presentation()?.path
            //
            //                shapeLayer?.add(anim, forKey: "path")
            //            }
        }
        get { return shapeLayer?.path?.uiPath }
        
    }
    
    func path(forBounds: CGRect) -> UIBezierPath
    {
        return UIBezierPath(ovalIn: forBounds)
    }
    
}
