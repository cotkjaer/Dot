//
//  ImageDot.swift
//  Dot
//
//  Created by Christian Otkjær on 17/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import UIKit

open class ImageDotView: DotView
{
    private let imageView = UIImageView(frame: .zero)
    
    open override var color: UIColor
    {
        set { imageView.tintColor = newValue }
        get { return imageView.tintColor }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect)
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
        imageView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        addSubview(imageView)
    }
    
    // MARK: - Interface Builder
    
    override open func prepareForInterfaceBuilder()
    {
        setup()
    }
    
    // MARK: - Image
    
//    override open func willMove(toSuperview newSuperview: UIView?)
//    {
//        super.willMove(toSuperview: newSuperview)
//        
//        updateDotImage()
//    }
    
    override open func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        updateDotImage()
    }
    
    public func updateDotImage()
    {
        let screen = window?.screen ?? UIScreen.main
        
        let size = CGSize(width: max(screen.bounds.width / 2, bounds.width * screen.scale), height: max(screen.bounds.height / 2, bounds.height * screen.scale))
        
        UIGraphicsBeginImageContext(size)
        
        defer { UIGraphicsEndImageContext() }
        
        UIColor.black.setFill()
        
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).fill()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
    }
}

@IBDesignable
public class ImageDot: UIImageView
{
    public var color : UIColor
    {
        set { tintColor = newValue }
        get { return tintColor }
        
    }
    
//    public override var backgroundColor: UIColor?
//        {
//        set { tintColor = newValue ?? tintColor }
//        get { return tintColor }
//    }
    
    public override func willMove(toSuperview newSuperview: UIView?)
    {
        super.willMove(toSuperview: newSuperview)
        
        updateDotImage()
    }
    
    public override func didMoveToSuperview()
    {
        super.didMoveToSuperview()
        updateDotImage()
    }
    
    public func updateDotImage()
    {
        let screen = window?.screen ?? UIScreen.main
        
        let size = CGSize(width: max(screen.bounds.width / 2, bounds.width * screen.scale), height: max(screen.bounds.height / 2, bounds.height * screen.scale))
        
        UIGraphicsBeginImageContext(size)

        defer { UIGraphicsEndImageContext() }
        
        UIColor.black.setFill()
        
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).fill()
        
        image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysTemplate)
    }
}
