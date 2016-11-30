//
//  WobbleViewController.swift
//  Dot
//
//  Created by Christian Otkjær on 24/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit
import Dot

class WobbleDot: DotView
{
    let dotLayer = CAShapeLayer()

    override var fillColor: UIColor?
    {
        set {
            dotLayer.fillColor = newValue?.cgColor
        }
        get {
            return dotLayer.fillColor?.uiColor
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup()
    {
        layer.addSublayer(dotLayer)
    }

    func path(for bounds : CGRect) -> UIBezierPath
    {
        return UIBezierPath(ovalIn: bounds)
    }
    
    func updatePath(bounds : CGRect)
    {
        let oldPath = dotLayer.path
        dotLayer.path = path(for: bounds).cgPath
        
        if wobbeling
        {
            let anim = CABasicAnimation(keyPath: "path")
            anim.duration = CATransaction.animationDuration()
            anim.timingFunction = CATransaction.animationTimingFunction()
            anim.beginTime = CACurrentMediaTime()
            anim.fromValue = oldPath
            anim.autoreverses = true
            
            dotLayer.add(anim, forKey: "path")
        }
//        if let anim = (dotLayer.action(forKey: "borderColor") as? CABasicAnimation)?.copy() as? CABasicAnimation
//        {
//            anim.fromValue = oldPath
//            anim.keyPath = "path"
//            
//            dotLayer.add(anim, forKey: "path")
//        }
    }
    
    override var bounds: CGRect
    {
        didSet { updatePath(bounds: bounds) }
    }
    
    var wobbeling = false

    let animationDuration = 0.15

    func createAnimation(keyPath: String, toValue : Any?) -> CABasicAnimation
    {
        let animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = nil
        animation.toValue = toValue
        animation.beginTime = 0.0
        animation.duration = animationDuration
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CATransaction.animationTimingFunction()
        animation.fillMode = kCAFillModeBoth
        
        return animation
    }
    
    func chain(animations : [CAAnimation]) -> CAAnimationGroup
    {
        var beginTime: CFTimeInterval = 0
        
        for a in animations
        {
            a.beginTime = beginTime
            beginTime += a.duration
        }
        
        let group = CAAnimationGroup()
        group.animations = animations
        group.duration = beginTime
        group.repeatCount = 3
        group.autoreverses = false//true
        group.isRemovedOnCompletion = true
        
        return group
    }
    
    func wobble(percent : CGFloat = 0.05)
    {
//        dotLayer.frame = bounds
        let transform = dotLayer.transform
        
//        let size = bounds.size//path?.boundingBox.size
        
        
        
//        let tall = CATransform3DTranslate(CATransform3DScale(transform, 0.9, 1.1, 1), -size.width * 0.05, 0, 0)
        let tall = CATransform3DScale(transform, 1-percent, 1+percent, 1)
        
//        let wide = CATransform3DTranslate(CATransform3DScale(transform, 1.1, 0.9, 1), 0, -size.height * 0.05, 0)
        let wide = CATransform3DScale(transform, 1+percent, 1-percent, 1)
        
        let a3 = createAnimation(keyPath: "transform", toValue: tall)
        let a2 = createAnimation(keyPath: "transform", toValue: transform)
        let a1 = createAnimation(keyPath: "transform", toValue: wide)
        let a4 = createAnimation(keyPath: "transform", toValue: transform)
        
        let g = chain(animations: [a1,a2,a3,a4])

        layer.add(g, forKey: "wobble")
    }
    
    func wibble()
    {
//        wobbeling = true
        
        let tall = bounds.insetBy(dx: sqrt(bounds.width), dy: -sqrt(bounds.height))

        let wide = bounds.insetBy(dx: -sqrt(bounds.height), dy: sqrt(bounds.height))
        

        let wobbleAnimation1: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation1.fromValue = nil
        wobbleAnimation1.toValue = path(for: wide).cgPath
        wobbleAnimation1.beginTime = 0.0
        wobbleAnimation1.duration = animationDuration
        wobbleAnimation1.isRemovedOnCompletion = false
        wobbleAnimation1.timingFunction = CATransaction.animationTimingFunction()
        wobbleAnimation1.fillMode = kCAFillModeBoth

        // 2
        let wobbleAnimation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation2.fromValue = nil//ovalPathSquishVertical.CGPath
        wobbleAnimation2.toValue = path(for: bounds).cgPath
        wobbleAnimation2.beginTime = wobbleAnimation1.beginTime + wobbleAnimation1.duration
        wobbleAnimation2.duration = animationDuration
        wobbleAnimation2.isRemovedOnCompletion = false
        wobbleAnimation2.timingFunction = CATransaction.animationTimingFunction()
        wobbleAnimation2.fillMode = kCAFillModeBoth

        // 3
        let wobbleAnimation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation3.fromValue = nil// ovalPathSquishHorizontal.CGPath
        wobbleAnimation3.toValue = path(for: tall).cgPath//ovalPathSquishVertical.CGPath
        wobbleAnimation3.beginTime = wobbleAnimation2.beginTime + wobbleAnimation2.duration
        wobbleAnimation3.duration = animationDuration
        wobbleAnimation3.isRemovedOnCompletion = false
        wobbleAnimation3.timingFunction = CATransaction.animationTimingFunction()
        wobbleAnimation3.fillMode = kCAFillModeBoth


        // 4
        let wobbleAnimation4: CABasicAnimation = CABasicAnimation(keyPath: "path")
        wobbleAnimation4.fromValue = nil// ovalPathSquishVertical.CGPath
        wobbleAnimation4.toValue = path(for: bounds).cgPath//ovalPathLarge.CGPath
        wobbleAnimation4.beginTime = wobbleAnimation3.beginTime + wobbleAnimation3.duration
        wobbleAnimation4.duration = animationDuration
        wobbleAnimation4.fillMode = kCAFillModeBoth
        wobbleAnimation4.isRemovedOnCompletion = false
        wobbleAnimation4.timingFunction = CATransaction.animationTimingFunction()
        
        
//        let t1 = CATransform3DMakeRotation(.pi, 0, 0, 1)
//        let wobbleAnimation5: CABasicAnimation = CABasicAnimation(keyPath: "transform")
//        wobbleAnimation5.fromValue = nil
//        wobbleAnimation5.toValue = t1
//        wobbleAnimation5.beginTime = 0.0
//        wobbleAnimation5.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
//        wobbleAnimation5.isRemovedOnCompletion = false
//        wobbleAnimation5.timingFunction = CATransaction.animationTimingFunction()
//        wobbleAnimation5.fillMode = kCAFillModeBoth
        
        let wobbleAnimationGroup: CAAnimationGroup = CAAnimationGroup()
        wobbleAnimationGroup.animations = [wobbleAnimation1, wobbleAnimation2, wobbleAnimation3, wobbleAnimation4]
        wobbleAnimationGroup.duration = wobbleAnimation4.beginTime + wobbleAnimation4.duration
        wobbleAnimationGroup.repeatCount = 2
        wobbleAnimationGroup.autoreverses = false//true
        wobbleAnimationGroup.isRemovedOnCompletion = true
        
        dotLayer.add(wobbleAnimationGroup, forKey: "wobble")
    }
}

class WobbleViewController: UIViewController
{
    @IBOutlet weak var wobbleDot: WobbleDot!

    @IBAction func wobble(_ sender: UITapGestureRecognizer)
    {
        wobbleDot.wobble()
    }
}
