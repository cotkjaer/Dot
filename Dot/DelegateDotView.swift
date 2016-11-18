//
//  DelegateDotView.swift
//  Dot
//
//  Created by Christian Otkjær on 18/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

/// Uses delegate drawing - cannot animate color and must have content-mode set to redraw to get nice edges
@IBDesignable
open class DelegateDotView : DotView
{
    open override func draw(_ layer: CALayer, in ctx: CGContext)
    {
        super.draw(layer, in: ctx)
        
        let path = UIBezierPath(ovalIn: layer.bounds).cgPath
        
        ctx.addPath(path)
        ctx.setFillColor(color.cgColor)
        ctx.fillPath()
    }
    
    open override func draw(_ rect: CGRect)
    {
    /// Needs an empty draw method to get background color and setNeedsDisplay working !?
    }
}
