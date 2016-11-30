//
//  DotLayerPathView.swift
//  Dot
//
//  Created by Christian Otkjær on 23/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

@IBDesignable
open class DotLayerPathView: UIView
{
    private let shapeLayer = CAShapeLayer()
    
    @IBInspectable
    open var fillColor: UIColor?
        {
        set { shapeLayer.fillColor = newValue?.cgColor }
        get { return shapeLayer.fillColor?.uiColor }
    }
    
    open var path : UIBezierPath?
        {
        set
        {
            shapeLayer.path = newValue?.cgPath
        }
        get { return shapeLayer.path?.uiPath }
        
    }
    
    func path(forBounds: CGRect) -> UIBezierPath
    {
        return UIBezierPath(ovalIn: forBounds)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        initialSetup()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        initialSetup()
    }
    
    override open func awakeFromNib()
    {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup()
    {
        layer.addSublayer(shapeLayer)
    }
    
    open override var bounds: CGRect
        {
        didSet
        {
            shapeLayer.path = path(forBounds: bounds).cgPath
            if let boundsSizeAnimKeys = layer.animationKeys()?.filter({ $0.hasPrefix("bounds.size") })
            {
                for key in boundsSizeAnimKeys
                {
                    if let anim = layer.animation(forKey: key)?.copy() as? CABasicAnimation
                    {
                        anim.keyPath = "path"
                        anim.fromValue = shapeLayer.path
                        anim.toValue = nil
                        
                        shapeLayer.add(anim, forKey: "path")
                    }
                }
            }
        }
    }
}
