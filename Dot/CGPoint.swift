//
//  CGPoint.swift
//  Dot
//
//  Created by Christian Otkjær on 17/11/16.
//  Copyright © 2016 Silverback IT. All rights reserved.
//

import Foundation

// MARK: - <#comment#>

extension CGPoint
{
    public func distance(to: CGPoint) -> CGFloat
    {
        return sqrt(pow(to.x - x, 2) + pow(to.y - y, 2))
    }
}

func - (lhs: CGPoint, rhs: CGPoint) -> CGVector
{
    return CGVector(dx: lhs.x - rhs.x, dy: lhs.y - rhs.y)
}
