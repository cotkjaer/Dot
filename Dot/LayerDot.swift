//
//  LayerDot.swift
//  Dot
//
//  Created by Christian Otkjær on 17/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation
import UIKit

open class LayerDotView : UpdatingDotView
{
    private let dotLayer = CAShapeLayer()
    
    // MARK: - Init
    
    public init()
    {
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    override open func awakeFromNib()
    {
        super.awakeFromNib()
        setup()
    }
    
    func setup()
    {
        layer.masksToBounds = false
        layer.addSublayer(dotLayer)
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder()
    {
        setup()
    }
    
    // MARK: - Update Dot
    
    var lastBounds = CGRect.zero
    
    override open func updateView()
    {
        dotLayer.fillColor = fillColor?.cgColor
        
        let bounds = layer.presentation()?.bounds ?? layer.bounds
        
        if bounds != lastBounds
        {
            lastBounds = bounds

            dotLayer.frame = bounds.insetBy(dx: -bounds.width, dy: -bounds.height)
            dotLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
            
            let ovalRect = CGRect(origin: CGPoint(x: bounds.width, y: bounds.height), size: bounds.size)
            
            let path = UIBezierPath(ovalIn: ovalRect)
            
            dotLayer.path = path.cgPath
        }
    }
}
