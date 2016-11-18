//
//  CornerDot.swift
//  Dot
//
//  Created by Christian Otkjær on 18/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

open class CornerDotView: UpdatingDotView
{
    open override var color: UIColor
    {
        didSet { backgroundColor = color }
    }
    
    override open func updateView()
    {
        let size = layer.presentation()?.frame.size ?? layer.frame.size
        
        layer.cornerRadius = min(size.width, size.height) / 2
    }
}
