//
//  MaskDot.swift
//  Dot
//
//  Created by Christian Otkjær on 17/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation

open class MaskDot: UpdatingDotView
{
    
    open override func updateView()
    {
        let b = layer.presentation()?.bounds ?? layer.bounds

        let mask = CAShapeLayer()

        mask.path = UIBezierPath(ovalIn: b).cgPath
        
        layer.mask = mask
    }
}
