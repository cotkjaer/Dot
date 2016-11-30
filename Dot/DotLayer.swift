//
//  DotLayer.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

let ColorKey = "color"

private func isCustomKey(_ key: String) -> Bool
{
    switch key
    {
    case ColorKey:
        return true
        
    default:
        return false
    }
}

class DotLayer: CALayer
{
    //NB No good for animations if the view is large, but may be extended with start and end cap
    
    @NSManaged
    open var color : CGColor?
    
    override init()
    {
        super.init()
        setupRasterize()
    }
    
    override init(layer: Any)
    {
        super.init(layer: layer)
        setupRasterize()
        
        guard let arcLayer = layer as? DotLayer else { return }
        
        color = arcLayer.color
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupRasterize()
        //        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRasterize()
    {
        shouldRasterize = true
        contentsScale = UIScreen.main.scale
        rasterizationScale = UIScreen.main.scale
    }
    
    override open class func needsDisplay(forKey key: String) -> Bool
    {
        return isCustomKey(key) || super.needsDisplay(forKey: key)
    }
    
    override open func action(forKey key: String) -> CAAction?
    {
        guard isCustomKey(key) else { return super.action(forKey: key) }
        
        // Get a fully configured animation if we are animating in a UIView.animate
        guard let animation = super.action(forKey: "backgroundColor") as? CABasicAnimation else { setNeedsDisplay(); return nil }
        
        animation.fromValue = presentation()?.value(forKey: key)
        animation.keyPath = key
        animation.toValue = nil
        
        return animation
    }
    
    override open func draw(in ctx: CGContext)
    {
        if !shouldRasterize { setupRasterize() }
        
        UIGraphicsPushContext(ctx)
        
        let path = UIBezierPath(ovalIn: bounds)
        
        if let fillColor = self.color?.uiColor
        {
            fillColor.setFill()
            
            path.fill()
        }
        
        UIGraphicsPopContext()
    }
}
