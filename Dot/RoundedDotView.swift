//
//  RoundedDotView.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

@IBDesignable
open class RoundedDotView: DotView
{
   override open class var layerClass : AnyClass
    {
        return RoundedLayer.self
    }
    
    @IBInspectable
    override open var fillColor: UIColor?
        {
        set { layer.backgroundColor = newValue?.cgColor }
        get { return layer.backgroundColor?.uiColor }
    }
    
    @IBInspectable
    override open var borderColor: UIColor?
        {
        set { layer.borderColor = newValue?.cgColor }
        get { return layer.borderColor?.uiColor }
    }
    @IBInspectable
    override open var borderWidth: CGFloat
        {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
}
