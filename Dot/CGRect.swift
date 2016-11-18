//
//  CGRect.swift
//  Dot
//
//  Created by Christian Otkjær on 16/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation

// MARK: - Center

extension CGRect
{
    public init(center: CGPoint, size: CGSize)
    {
        self.init(origin: CGPoint(x: center.x - size.width/2, y: center.y - size.height/2), size: size)
    }
    
    public var center : CGPoint
        {
        get { return CGPoint(x: midX, y: midY) }
        set { origin = CGPoint(x: newValue.x - width / 2, y: newValue.y - height / 2) }
    }
}
