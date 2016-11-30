//
//  DrawnLayerDotView.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

@IBDesignable
open class DrawnLayerDotView: UIView
{
    private var arcLayer : DotLayer? { return layer as? DotLayer }
    
    @IBInspectable
    open var fillColor: UIColor?
        {
        set { arcLayer?.color = newValue?.cgColor }
        get { return arcLayer?.color?.uiColor }
    }
    
    override open class var layerClass : AnyClass
    {
        return DotLayer.self
    }
}

