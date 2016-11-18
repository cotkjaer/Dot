//
//  DotView.swift
//  Dot
//
//  Created by Christian Otkjær on 16/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

//public typealias Dot = DelegateDotView

/// Should be a type-alias, but interface builder cannot use typealiases 
public class Dot : DelegateDotView
{
    
}

@IBDesignable
/// Abstract super-class for different Dot strategies
open class DotView : UIView
{
    /// The color of the dot
    @IBInspectable
    open var color : UIColor = .orange
        {
        didSet { if oldValue != color { setNeedsDisplay() } }
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder()
    {
        setNeedsDisplay()
    }
    
    override open var intrinsicContentSize: CGSize
    {
        return CGSize(width: 40, height:  40)
    }
}
