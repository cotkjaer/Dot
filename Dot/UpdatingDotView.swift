//
//  UpdatingDotView.swift
//  Dot
//
//  Created by Christian Otkjær on 18/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

/// Abstract superclass for DotViews that depend on CADisplayLink to handle animations
open class UpdatingDotView: DotView
{
    open func updateView()
    {
        debugPrint("override")
    }

    private var displayLink : CADisplayLink?
    
    private func setUpDisplayLink()
    {
        guard displayLink == nil else { return }
        
        displayLink = CADisplayLink(target: self, selector: #selector(type(of: self).updateView))
        
        displayLink?.isPaused = false
        
        displayLink?.add(to: .main, forMode: .commonModes)
    }
    
    private func takeDownDisplayLink()
    {
        guard displayLink != nil else { return }
        
        displayLink?.isPaused = true
        
        displayLink?.remove(from: .main, forMode: .commonModes)
    }
    
    override open func willMove(toSuperview newSuperview: UIView?)
    {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil
        {
            takeDownDisplayLink()
        }
        else
        {
            setUpDisplayLink()
        }
    }
}
